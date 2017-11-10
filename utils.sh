# $1 - variable name
# $2 - string 
function escape_chars() {
    # printf -v $1 "%q\n" "hello\world"
    var_name=$1;shift
    # printf -v $var_name $@ "%q\n" "hello\world"
    printf -v $var_name "%q\n" $@
}
