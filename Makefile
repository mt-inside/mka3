a3.html: data/a3.xml data/*.xml *.xsl
	xsltproc --stringparam date "`date "+%d %B %Y"`" mka3.xsl $< > $@

clean:
	@rm -f a3.html
