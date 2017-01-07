#!/bin/sh

if [ "x$1" = "x-ok" -a -f _.fl ] ; then
	echo "Saved as reference"
	mv _.fl _.fl.old
	exit 0
fi

flexelint \
	../../flint.lnt \
	../flint.lnt \
	flint.lnt \
	-I. \
	-I../../include \
	-I../../lib/libvgz \
	-I../.. \
	-I/usr/local/include \
	-DVARNISHD_IS_NOT_A_VMOD \
	-DVARNISH_STATE_DIR=\"foo\" \
	-DVARNISH_VMOD_DIR=\"foo\" \
	-DVARNISH_VCL_DIR=\"foo\" \
	cache/*.c \
	common/*.c \
	hash/*.c \
	http1/*.c \
	http2/*.c \
	mgt/*.c \
	proxy/*.c \
	storage/*.c \
	waiter/*.c \
	../../lib/libvarnish/*.c \
	../../lib/libvcc/*.c \
	../../lib/libvmod_std/*.c \
	../../lib/libvmod_debug/*.c \
	../../lib/libvmod_directors/*.c \
	2>&1 | tee _.fl

if [ -f _.fl.old ] ; then
	diff -u _.fl.old _.fl
fi

if [ "x$1" = "x-ok" ] ; then
	echo "Saved as reference"
	mv _.fl _.fl.old
fi
