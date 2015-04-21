package Ptero::Concrete::Detail::Workflow::Converge;

use Moose;
use warnings FATAL => 'all';

use Params::Validate qw(validate_pos :types);

use Ptero::Concrete::Detail::Workflow::Execution;

extends 'Ptero::Builder::Detail::Workflow::Converge';
with 'Ptero::Concrete::Detail::Roles::CanWriteReport';
with 'Ptero::Concrete::Detail::Roles::HasExecutions';

sub _write_report {
    return;
}

__PACKAGE__->meta->make_immutable;