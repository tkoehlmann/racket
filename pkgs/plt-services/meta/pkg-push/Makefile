# ------------------------------------------------------------
# Configuration

# This `racket' must have the the "distro-build" and "aws" packages
# installed:
RACKET = racket

# In `PLT_TOP', "build/latest" should be a git clone to update (and it
# shouldn't be the clone that implements `RACKET'), and other files
# will be written and cached at "build":
PLT_TOP = ../../../..

# Along with the following, "~/.aws-keys" must have your AWS keys in
# the form
#     AWSAccessKeyId=....
#     AWSSecretKey=....
S3_HOST = s3-us-west-2.amazonaws.com
BUCKET = racket-packages

# The catalog server to update:
DEST_CATALOG = https://localhost:9004

# ------------------------------------------------------------
# Targets

# Make `push' periodically to push packages to pkgs.racket-lang.org:
push:
	$(MAKE) pull-latest-from-git
	$(MAKE) archive-catalog
	$(MAKE) push-catalog

# Update repo checkout in "build/latest" --- assuming that the
# repo has been checked out before.
pull-latest-from-git:
	cd $(PLT_TOP)/build/latest && git pull && git submodule update

# Assemble all packages from a repo checkout into ".zip" form
# to checksum-based subdirectories of "build/archive/pkgs"
# and a catalog in "build/archive/catalog":
PACK_ARCHIVE = --at-checksum $(PLT_TOP)/build/archive/pkgs \
               --pack $(PLT_TOP)/build/archive/pre-pkgs \
               ++catalog $(PLT_TOP)/build/archive/catalog
archive-catalog:
	rm -rf $(PLT_TOP)/build/archive/catalog
	$(RACKET) -l- distro-build/pack-and-catalog --native $(PACK_ARCHIVE) $(PLT_TOP)/build/latest/native-pkgs
	$(RACKET) -l- distro-build/pack-and-catalog $(PACK_ARCHIVE) $(PLT_TOP)/build/latest/pkgs

# Copy files from "build/archive" to $(BUCKET), and update
# $(DEST_CATALOG):
AWS_AND_CATALOG = $(S3_HOST) $(BUCKET) $(DEST_CATALOG)
push-catalog:
	$(RACKET) push-catalog.rkt $(PLT_TOP)/build/archive $(AWS_AND_CATALOG)
