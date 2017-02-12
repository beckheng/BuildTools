#!/usr/bin/perl

use strict;

use FindBin qw($Bin);
use File::Find;

$|++;

my $PROTOC_CMD = "$Bin/../ProtoGen/protoc";
my $PROTOGEN_CMD = "$Bin/../ProtoGen/protogen";

my $protobufDefinePath = "$Bin/../../ProtobufDefine";
my $protobufTempPath = "$Bin/../../ProtobufTemp";

if (!-e $protobufTempPath){
	mkdir($protobufTempPath);
}

my $protobufClassesPath = "$Bin/../../Assets/Scripts/ProtobufClasses";

if (!-e $protobufClassesPath){
	mkdir($protobufClassesPath);
}

find({ wanted => \&process, no_chdir => 0}, $protobufDefinePath);

sub process{
	if (-d $File::Find::name){
		return;
	}
	
	print "开始生成 " . $File::Find::name, " ";
	
	my $outputPath = $protobufTempPath . "/" . $_ . ".bin";
	
	my $status;
	
	$status = system($PROTOC_CMD, "-I$protobufDefinePath", $File::Find::name, "-o$outputPath");
	if ($status){
		die "protoc生成出错\n";
	}
	
	my $csPath = $protobufClassesPath . "/" . $_ . ".cs";
	$status = system($PROTOGEN_CMD, "-i:$outputPath", "-o:$csPath", "-q");
	if ($status){
		die "生成cs类出错\n";
	}
	
	print "成功\n";
}
