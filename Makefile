VER=1.10.3
REL=1

all: clean
	# Download
	wget -c https://releases.hashicorp.com/consul/${VER}/consul_${VER}_linux_amd64.zip
	# Prepare workdir
	mkdir -p ./src
	cd src; unzip ../consul_${VER}_linux_amd64.zip
	# Build
	fpm \
		-s dir -t deb \
		-n 'consul-bin' -v ${VER}-${REL} \
		--after-install=postinstall.sh \
		./src/consul=/usr/bin/consul \
		consul.service=/usr/lib/systemd/system/consul.service \
		consul.sysusers=/usr/lib/sysusers.d/consul.conf \
		config.hcl=/etc/consul.d/config.hcl

clean:
	rm -rf ./src
	rm -f *.deb

mrproper: clean
	rm -f consul_*_linux_amd64.zip

install:
	dpkg -i consul-bin_${VER}-${REL}_amd64.deb
