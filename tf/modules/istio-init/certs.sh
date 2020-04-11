#! /bin/bash

set -e

certdir=.pki
mkdir -p ${certdir}

# Generate the root CA key
openssl genrsa -out ${certdir}/root-ca-key.pem 4096

# Generate the root CA crt
openssl req \
        -x509 \
        -new \
        -nodes \
        -key ${certdir}/root-ca-key.pem \
        -sha256 \
        -days 1024 \
        -out ${certdir}/root-cert.pem \
        -subj "/C=ZZ/ST=BananaRepublic/L=ZombieLand/O=MonsterInc/OU=ScaresDivision/CN=My Root CA"

# Generate intermediate CA Key
openssl genrsa -out ${certdir}/ca-key.pem 4096

cat > ${certdir}/ca.cfg <<EOF
[ citadel_ca ]
basicConstraints=CA:TRUE
keyUsage=keyCertSign
subjectAltName=DNS:*.svc.local,DNS:localhost,DNS:ca.istio.io
EOF


# Generate intermediate CA csr
openssl req \
        -new \
        -key ${certdir}/ca-key.pem \
        -subj "/C=ZZ/ST=BananaRepublic/L=ZombieLand/O=MonsterInc/OU=DraculaDivison/CN=My interm CA" \
        -out ${certdir}/ca.csr

# Sign the csr and generate intermediate ca crt
openssl x509 \
        -req \
        -days 1000 \
        -in ${certdir}/ca.csr \
        -extfile ${certdir}/ca.cfg \
        -extensions citadel_ca \
        -CA ${certdir}/root-cert.pem \
        -CAkey ${certdir}/root-ca-key.pem \
        -CAcreateserial  \
        -out ${certdir}/ca-cert.pem

cp ${certdir}/ca-cert.pem ${certdir}/cert-chain.pem
