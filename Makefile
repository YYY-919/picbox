# memebox generating

PAGELANG?=zh

TITLE?=PicBox
DESC?=♂DO YOU LIKE VAN YOU SEE ?♂
FOOTER?= ---没了---

ifeq (${PAGELANG}, zh)
T_MEMEPIC?=图片
T_MEMETXT?=文字
T_DOWNLOAD?=下载图片
T_ANOTHER?=图片不喜欢？换一张试试看
T_BACK?=返回画廊
T_ZOOMIN?=查看大图
endif

T_MEMEPIC?=Picture memes
T_MEMETXT?=Text memes
T_DOWNLOAD?=Download
T_ANOTHER?=Not prefer to it? Try another one
T_BACK?=Back to gallery
T_ZOOMIN?=Zoom in


.PHONY: clean icon

all: shell static .github index.html icon

index.html shell/genartlist.sh shell/art2text.sh: %: src/%.in
	sed 's%@TITLE@%${TITLE}%g' $^ \
		| sed 's%@DESC@%${DESC}%g' \
		| sed 's%@FOOTER@%${FOOTER}%g' \
		| sed 's%@PAGELANG@%${PAGELANG}%g' \
		| sed 's%@T_MEMEPIC@%${T_MEMEPIC}%g' \
		| sed 's%@T_MEMETXT@%${T_MEMETXT}%g' \
		| sed 's%@T_DOWNLOAD@%${T_DOWNLOAD}%g' \
		| sed 's%@T_ANOTHER@%${T_ANOTHER}%g' \
		| sed 's%@T_BACK@%${T_BACK}%g' \
		| sed 's%@T_ZOOMIN@%${T_ZOOMIN}%g' > $@

icon:
	@echo
	@echo "*** Two icon files are used:"
	@echo "***     - static/favicon.ico"
	@echo "***     - static/favicon.png"
	@echo "*** Please put your icons to the right place."

shell static .github:
	mkdir -pv shell static/data/images
	touch static/data/.gitkeep static/data/images/.gitkeep
	cp -rf src/.github src/static .
	cp -rf src/shell/computed.sh src/shell/imgcheck.py shell/

clean:
	rm -rfv .github shell static index.html
