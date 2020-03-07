#!/bin/bash
if [[ $1 == "--verbose" ]]; then
  lets completion -s zsh --verbose > _lets
else
  lets completion -s zsh > _lets
fi