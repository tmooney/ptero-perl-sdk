requires 'perl' => '5.10.1';

requires "Data::Dump";
requires "File::Slurp";
requires "Graph";
requires "HTTP::Request";
requires "JSON";
requires "LWP::UserAgent::Determined";
requires "Log::Log4perl";
requires "Moose";
requires "MooseX::Aliases";
requires "Params::Validate";
requires "Set::Scalar";
requires "Template";
requires "DateTime::Format::Strptime";
requires "Date::Calc";
requires "IO::String";

on 'test' => sub {
    requires "Test::Exception";
    requires "Devel::Cover";
    requires "Devel::Cover::Report::Coveralls";
    requires "Text::Diff";
    requires "Data::UUID";
    requires "Sub::Install";
};
