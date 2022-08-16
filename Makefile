all: lovefile win64

lovefile:
	@rm -rf build/lovefile
	@mkdir -p build/lovefile

	@cd src/love; zip -r -9 ../../build/lovefile/Untitled-Game.love .

	@mkdir -p build/release
	@rm -f build/release/Untitled-Game-lovefile.zip
	@cd build/lovefile; zip -9 -r ../release/Untitled-Game-lovefile.zip .
win64: lovefile
	@rm -rf build/win64
	@mkdir -p build/win64

	@cp resources/win64/love/OpenAL32.dll build/win64
	@cp resources/win64/love/SDL2.dll build/win64
	@cp resources/win64/love/license.txt build/win64
	@cp resources/win64/love/lua51.dll build/win64
	@cp resources/win64/love/mpg123.dll build/win64
	@cp resources/win64/love/love.dll build/win64
	@cp resources/win64/love/msvcp120.dll build/win64
	@cp resources/win64/love/msvcr120.dll build/win64

	@cat resources/win64/love/love.exe build/lovefile/Untitled-Game.love > build/win64/Untitled-Game.exe

	@mkdir -p build/release
	@rm -f build/release/Untitled-Game-win64.zip
	@cd build/win64; zip -9 -r ../release/Untitled-Game-win64.zip .
	