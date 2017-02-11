命令行示例

1.先使用protoc生成文件
	protoc -If:\eee f:\eee\Test.proto -of:\eee\Test.bin
	
	
2. 使用protogen生成.cs文件
	protogen.exe -if:\eee\Test.bin