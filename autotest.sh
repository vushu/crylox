#!/usr/bin/bash
ls src/* | entr -r crystal spec
