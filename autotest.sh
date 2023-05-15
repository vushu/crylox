#!/usr/bin/bash
ls src/* spec/* | entr -r crystal spec
