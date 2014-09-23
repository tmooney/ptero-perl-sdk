use strict;
use warnings FATAL => 'all';

use Test::Exception;
use Test::More;
use File::Slurp qw();


my $test_dir = sprintf '%s.d', __FILE__;

use_ok('Ptero::WorkflowBuilder::DAG');

my $operation_methods = [
    {
        name => 'shortcut',
        submitUrl => 'http://ptero-fork/v1/jobs',
        parameters => {
            commandLine => ['genome-ptero-wrapper',
                'command', 'shortcut', 'NullCommand']
        },
    },
    {
        name => 'execute',
        submitUrl => 'http://ptero-lsf/v1/jobs',
        parameters => {
            commandLine => ['genome-ptero-wrapper',
                'command', 'execute', 'NullCommand'],
            limit => {
                virtual_memory => 204800,
            },
            request => {
                min_cores => 4,
                memory => 200,
                temp_space => 5,
            },
            reserve => {
                min_cores => 4,
                memory => 200,
                temp_space => 5,
            },
        },
    },
];

my $operations = {
    A => {
        methods => $operation_methods,
    },
    B => {
        methods => $operation_methods,
    },
};

my $edges = [
    {
        source => 'input connector',
        destination => 'A',
        source_property => 'in_a',
        destination_property => 'param',
    },
    {
        source => 'input connector',
        destination => 'B',
        source_property => 'in_b',
        destination_property => 'param',
    },
    {
        source => 'A',
        destination => 'output connector',
        source_property => 'out_a',
        destination_property => 'out_a',
    },
    {
        source => 'B',
        destination => 'output connector',
        source_property => 'out_a',
        destination_property => 'out_b',
    },
    {
        source => 'A',
        destination => 'B',
        source_property => 'out_a',
        destination_property => 'a_to_b',
    },
];

sub get_test_json {
    my $json_filename = File::Spec->join($test_dir, 'blessed-dag.json');
    my $blessed_json = File::Slurp::read_file($json_filename);
    chomp($blessed_json);

    return $blessed_json;
}

sub regenerate_test_data {
    my $dag = shift;
    my $json_filename = File::Spec->join($test_dir, 'blessed-dag.json');
    if ($ENV{REGENERATE_TEST_DATA}) {
        File::Slurp::write_file($json_filename, $dag->to_json(pretty => 1) . "\n");
    }
}

{
    my $hashref = {
        nodes => $operations,
        edges => $edges,
    };

    my $dag = Ptero::WorkflowBuilder::DAG->from_hashref($hashref, 'some-workflow');
    regenerate_test_data($dag);

    is($dag->to_json(pretty => 1), get_test_json(), 'encode_as_json');
}

{
    my $blessed_json = get_test_json();
    my $dag = Ptero::WorkflowBuilder::DAG->from_json($blessed_json, 'some-workflow');
    is($dag->to_json, $blessed_json, 'json roundtrip');
}

done_testing();
