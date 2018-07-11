#!/bin/bash
# This is the script used by Jenkins to generate API documentation.
# Editing it will have no effect on the Jenkins build pipeline, ask a UBports
# Jenkins admin to do that for you.

GH_PAGES_SOURCES="sdk conf.py Makefile README.md requirements.txt"

pip install -r requirements.txt
git checkout gh-pages
rm -rf build _sources _static
git checkout master $GH_PAGES_SOURCES
git reset HEAD
sphinx-build -a -j 70 . _build/html
sphinx-build -a -j 70 -b epub . _build/epub
rm -rf $GH_PAGES_SOURCES
mv -fv _build/html/* ./
mv -fv _build/epub/*.epub ./
rm -rf _build
touch .nojekyll
echo "api-docs.ubports.com" > CNAME
git add -A
git commit -m "Generated gh-pages for `git log master -1 --pretty=short --abbrev-commit`"
