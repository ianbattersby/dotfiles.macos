#!/bin/bash

function terraform_default_to_recursive() {
  case $* in
    fmt* ) shift 1; command terraform fmt --recursive "$@" ;;
    * ) command terraform "$@" ;;
  esac
}

alias tf='terraform_default_to_recursive'
alias tfv='terraform fmt --recursive; terraform validate'
