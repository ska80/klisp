DATE=	20190222

CFLAGS=		-g -O0 -ansi

all:	kl klisp

kl:	kl.c
	$(CC) $(CFLAGS) -o kl kl.c

klisp:	kl klsrc
	rm -f klisp && echo "(load 'klsrc) (suspend 'klisp)" | ./kl

test:	kl klisp
	./kl <kltest >kltest.tmp
	diff kltest.ok kltest.tmp && rm -f kltest.tmp

csums:
	csum -u <_checksums >_checksums.new
	mv -f _checksums.new _checksums

clean:
	rm -f *.o *.a a.out *.core core kl klisp kltest.tmp klisp.tgz

mksums:	clean
	find . -type f | grep -v _checksums | grep -v klisp.tgz \
		| sort | csum -m >_checksums

arc:	clean
	(cd ..; tar cfz klisp.tgz klisp) && mv ../klisp.tgz .

