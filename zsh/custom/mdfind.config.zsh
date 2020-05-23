function s() {
    mdfind -onlyin . $1 | xargs grep -inH $1
}
