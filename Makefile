a3.html: a3.xml mka3.xsl
	xsltproc --stringparam date "`date "+%d %B %Y"`" mka3.xsl $< > $@

clean:
	@rm -f a3.html
