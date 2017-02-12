#!/usr/bin/perl

use strict;

use FindBin qw($Bin);

my $UNITY_CMD = '"C:\\Program Files\\Unity\\Editor\\Unity.exe"';

my $PROJ_PATH = "$Bin/../..";

my @UNITY_ARGS = ('-quit', '-batchmode', '-executeMethod', 'Builder.BuildAPK');

push @UNITY_ARGS, '-buildTarget', 'android';

push @UNITY_ARGS, '-projectPath', $PROJ_PATH;

system($UNITY_CMD, @UNITY_ARGS);
