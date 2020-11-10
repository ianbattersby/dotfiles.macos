#!/bin/bash
function terraform_default_to_recursive() {
  case $* in
    fmt* ) shift 1; command terraform fmt --recursive "$@" ;;
    validate*) shift 1
        # Is this a module directory we are starting from
        ([[ -f "$(pwd)/versions.tf" ]] && [[ -f "$(pwd)/VERSION" ]]) && is_search_root_module=true || is_search_root_module=false

        # Is this a parent directory for modules we are starting from
        [[ -z  "${$(pwd)##*/modules}" ]] && is_search_root_module_parent=true || is_search_root_module_parent=false

        # Find potential module directories and iterate
        command find -E . -type d -regex '.*\.*(modules|.)' -not -path "*.terraform*" -not -path "*.git*" \
            -exec env is_search_root_module=$is_search_root_module is_search_root_module_parent=$is_search_root_module_parent \
                sh -c '
        for directory do
            # Does this directory contain terraform files
            for f in $directory/*.tf; do
                if [[ -f $f ]]; then
                    tf_files_exist=true
                    break
                fi
                tf_files_exist=false
            done

            # Is terraform directory, but not a module
            ([[ $is_search_root_module == false ]] && [[ -f "$directory/terraform.tf" ]]) && is_terraform_root=true || is_terraform_root=false

            # Is actually a module
            [[ $tf_files_exist == true ]] && [[ $is_terraform_root == false ]] && (([[ $is_search_root_module == true ]] && [[ $directory == "." ]]) || ([[ $is_search_root_module_parent == true ]] && [[ $directory != "." ]]) || [[ -f "$directory/versions.tf" ]] || [[ -z "${directory##*/modules/*}" ]]) && is_terraform_module=true || is_terraform_module=false

            # Is independently built (if not they should be directly consumed and validated by the consumer)
            [[ $is_terraform_module == true ]] && ([[ -f "$directory/cloudbuild_master_push.yaml" ]] || [[ -f "$directory/cloudbuild_main_push.yaml" ]]) && is_independent_module=true || is_independent_module=false

            # echo $directory
            # echo "\$is_search_root_module "$is_search_root_module
            # echo "\$is_search_root_module_parent "$is_search_root_module_parent
            # echo "\$is_terraform_root "$is_terraform_root
            # echo "\$is_terraform_module "$is_terraform_module
            # echo "\$is_independent_module "$is_independent_module
            # echo ""

            if [ $is_terraform_root == true ]; then
                echo "Skipping: "$directory" (requires state)"
            elif [ $is_terraform_module == true ] && [ $is_independent_module == false ]; then
                echo "Skipping: "$directory" (direct dependency)"
            elif [ $is_independent_module == true ] && [ -n "${directory##*.terraform*}" ] && [ -n "${directory##*modules}" ]; then
                pushd $directory > /dev/null
                echo "Validating: "$directory
                terraform init 1> /dev/null
                terraform validate 1> /dev/null
                popd > /dev/null
            fi
        done' sh {} + ;;
    * ) command terraform "$@" ;;
  esac
}

alias tf='terraform_default_to_recursive'
alias tfv='terraform_default_to_recursive fmt;terraform_default_to_recursive validate'
