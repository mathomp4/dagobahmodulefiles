prepend_path("PATH","/Users/mathomp4/spack-mathomp4/bin")
setenv("SPACK_PYTHON","/Users/mathomp4/.homebrew/brew/bin/python3")
setenv("SPACK_ROOT","/Users/mathomp4/spack-mathomp4")
set_alias("spacktivate","spack env activate")
set_shell_function("_all_packages"," \
    if [[ -z \"${SPACK_ALL_PACKAGES:-}\" ]]; then\
        SPACK_ALL_PACKAGES=\"$(spack list)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_ALL_PACKAGES\"\
","")
set_shell_function("_all_resource_hashes"," \
    if [[ -z \"${SPACK_ALL_RESOURCES_HASHES:-}\" ]]; then\
        SPACK_ALL_RESOURCE_HASHES=\"$(spack resource list --only-hashes)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_ALL_RESOURCE_HASHES\"\
","")
set_shell_function("_bash_completion_spack"," \
    local -a COMP_WORDS_NO_FLAGS;\
    local index=0;\
    while [[ \"$index\" -lt \"$COMP_CWORD\" ]]; do\
        if [[ \"${COMP_WORDS[$index]}\" == [a-z]* ]]; then\
            COMP_WORDS_NO_FLAGS+=(\"${COMP_WORDS[$index]}\");\
        fi;\
        let index++;\
    done;\
    local subfunction=$(IFS='_'; echo \"_${COMP_WORDS_NO_FLAGS[*]}\");\
    subfunction=${subfunction//-/_};\
    COMP_WORDS_NO_FLAGS+=(\"${COMP_WORDS[$COMP_CWORD]}\");\
    local COMP_CWORD_NO_FLAGS=$((${#COMP_WORDS_NO_FLAGS[@]} - 1));\
    local list_options=false;\
    if [[ \"${COMP_WORDS[$COMP_CWORD]}\" == -* || \"$COMP_POINT\" -ne \"${#COMP_LINE}\" ]]; then\
        list_options=true;\
    fi;\
    local cur=${COMP_WORDS_NO_FLAGS[$COMP_CWORD_NO_FLAGS]};\
    if [[ \"${COMP_LINE:$COMP_POINT-1:1}\" == \" \" ]]; then\
        cur=\"\";\
    fi;\
    local rgx;\
    rgx=\"$subfunction.*function.* \";\
    if [[ \"$(LC_ALL=C type $subfunction 2>&1)\" =~ $rgx ]]; then\
        $subfunction;\
        COMPREPLY=($(compgen -W \"$SPACK_COMPREPLY\" -- \"$cur\"));\
    fi\
","")
set_shell_function("_config_sections"," \
    if [[ -z \"${SPACK_CONFIG_SECTIONS:-}\" ]]; then\
        SPACK_CONFIG_SECTIONS=\"$(spack config list)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_CONFIG_SECTIONS\"\
","")
set_shell_function("_environments"," \
    if [[ -z \"${SPACK_ENVIRONMENTS:-}\" ]]; then\
        SPACK_ENVIRONMENTS=\"$(spack env list)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_ENVIRONMENTS\"\
","")
set_shell_function("_extensions"," \
    if [[ -z \"${SPACK_EXTENSIONS:-}\" ]]; then\
        SPACK_EXTENSIONS=\"$(spack extensions)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_EXTENSIONS\"\
","")
set_shell_function("_installed_compilers"," \
    if [[ -z \"${SPACK_INSTALLED_COMPILERS:-}\" ]]; then\
        SPACK_INSTALLED_COMPILERS=\"$(spack compilers | egrep -v \"^(-|=)\")\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_INSTALLED_COMPILERS\"\
","")
set_shell_function("_installed_packages"," \
    if [[ -z \"${SPACK_INSTALLED_PACKAGES:-}\" ]]; then\
        SPACK_INSTALLED_PACKAGES=\"$(spack --color=never find --no-groups)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_INSTALLED_PACKAGES\"\
","")
set_shell_function("_keys"," \
    if [[ -z \"${SPACK_KEYS:-}\" ]]; then\
        SPACK_KEYS=\"$(spack gpg list)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_KEYS\"\
","")
set_shell_function("_mirrors"," \
    if [[ -z \"${SPACK_MIRRORS:-}\" ]]; then\
        SPACK_MIRRORS=\"$(spack mirror list | awk '{print $1}')\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_MIRRORS\"\
","")
set_shell_function("_pretty_print"," \
    for arg in $@;\
    do\
        local array=(\"${!arg}\");\
        printf \"$arg: [\";\
        printf \"'%s'\" \"${array[0]}\";\
        printf \", '%s'\" \"${array[@]:1}\";\
        echo \"]\";\
    done\
","")
set_shell_function("_providers"," \
    if [[ -z \"${SPACK_PROVIDERS:-}\" ]]; then\
        SPACK_PROVIDERS=\"$(spack providers)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_PROVIDERS\"\
","")
set_shell_function("_repos"," \
    if [[ -z \"${SPACK_REPOS:-}\" ]]; then\
        SPACK_REPOS=\"$(spack repo list | awk '{print $1}')\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_REPOS\"\
","")
set_shell_function("_sp_multi_pathadd"," \
    local IFS=':';\
    if [ \"$_sp_shell\" = zsh ]; then\
        emulate -L sh;\
    fi;\
    for pth in $2;\
    do\
        for systype in ${_sp_compatible_sys_types};\
        do\
            _spack_pathadd \"$1\" \"${pth}/${systype}\";\
        done;\
    done\
","")
set_shell_function("_spack"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -H --all-help --color -c --config -C --config-scope -d --debug --timestamp --pdb -e --env -D --env-dir -E --no-env --use-env-repo -k --insecure -l --enable-locks -L --disable-locks -m --mock -b --bootstrap -p --profile --sorted-profile --lines -v --verbose --stacktrace --backtrace -V --version --print-shell-vars\";\
    else\
        SPACK_COMPREPLY=\"add arch audit blame bootstrap build-env buildcache cd change checksum ci clean clone commands compiler compilers concretize config containerize create debug dependencies dependents deprecate dev-build develop diff docs edit env extensions external fetch find gc gpg graph help info install license list load location log-parse maintainers make-installer mark mirror module patch pkg providers pydoc python reindex remove rm repo resource restage solve spec stage style tags test test-env tutorial undevelop uninstall unit-test unload url verify versions view\";\
    fi\
","")
set_shell_function("_spack_add"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -l --list-name\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_arch"," \
    SPACK_COMPREPLY=\"-h --help -g --generic-target --known-targets -p --platform -o --operating-system -t --target -f --frontend -b --backend\"\
","")
set_shell_function("_spack_audit"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"configs packages-https packages list\";\
    fi\
","")
set_shell_function("_spack_audit_configs"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_audit_list"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_audit_packages"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_audit_packages_https"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --all\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_blame"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -t --time -p --percent -g --git --json\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_bootstrap"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"now status enable disable reset root list add remove mirror\";\
    fi\
","")
set_shell_function("_spack_bootstrap_add"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope --trust\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_bootstrap_disable"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_bootstrap_enable"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_bootstrap_list"," \
    SPACK_COMPREPLY=\"-h --help --scope\"\
","")
set_shell_function("_spack_bootstrap_mirror"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --binary-packages --dev\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_bootstrap_now"," \
    SPACK_COMPREPLY=\"-h --help --dev\"\
","")
set_shell_function("_spack_bootstrap_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_bootstrap_reset"," \
    SPACK_COMPREPLY=\"-h --help -y --yes-to-all\"\
","")
set_shell_function("_spack_bootstrap_root"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_bootstrap_status"," \
    SPACK_COMPREPLY=\"-h --help --optional --dev\"\
","")
set_shell_function("_spack_build_env"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --clean --dirty -U --fresh --reuse --reuse-deps --dump --pickle\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_buildcache"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"push create install list keys preview check download get-buildcache-name save-specfile sync update-index rebuild-index\";\
    fi\
","")
set_shell_function("_spack_buildcache_check"," \
    SPACK_COMPREPLY=\"-h --help -m --mirror-url -o --output-file --scope -s --spec --spec-file\"\
","")
set_shell_function("_spack_buildcache_create"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -f --force --allow-root -a --unsigned -u --key -k --update-index --rebuild-index --spec-file --only --fail-fast\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_buildcache_download"," \
    SPACK_COMPREPLY=\"-h --help -s --spec --spec-file -p --path\"\
","")
set_shell_function("_spack_buildcache_get_buildcache_name"," \
    SPACK_COMPREPLY=\"-h --help -s --spec --spec-file\"\
","")
set_shell_function("_spack_buildcache_install"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -f --force -m --multiple -u --unsigned -o --otherarch\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_buildcache_keys"," \
    SPACK_COMPREPLY=\"-h --help -i --install -t --trust -f --force\"\
","")
set_shell_function("_spack_buildcache_list"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -l --long -L --very-long -N --namespaces -v --variants -a --allarch\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_buildcache_preview"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_buildcache_push"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -f --force --allow-root -a --unsigned -u --key -k --update-index --rebuild-index --spec-file --only --fail-fast\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_buildcache_rebuild_index"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -k --keys\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_buildcache_save_specfile"," \
    SPACK_COMPREPLY=\"-h --help --root-spec --root-specfile -s --specs --specfile-dir\"\
","")
set_shell_function("_spack_buildcache_sync"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --manifest-glob\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_buildcache_update_index"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -k --keys\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_cd"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -m --module-dir -r --spack-root -i --install-dir -p --package-dir -P --packages -s --stage-dir -S --stages --source-dir -b --build-dir -e --env --first\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_change"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -l --list-name --match-spec -a --all\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_checksum"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --keep-stage -b --batch -l --latest -p --preferred -a --add-to-package --verify\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_ci"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"generate rebuild-index rebuild reproduce-build\";\
    fi\
","")
set_shell_function("_spack_ci_generate"," \
    SPACK_COMPREPLY=\"-h --help --output-file --copy-to --optimize --dependencies --buildcache-destination --prune-dag --no-prune-dag --check-index-only --artifacts-root\"\
","")
set_shell_function("_spack_ci_rebuild"," \
    SPACK_COMPREPLY=\"-h --help -t --tests --fail-fast\"\
","")
set_shell_function("_spack_ci_rebuild_index"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_ci_reproduce_build"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --runtime --working-dir -s --autostart --gpg-file --gpg-url\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_clean"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -s --stage -d --downloads -f --failures -m --misc-cache -p --python-cache -b --bootstrap -a --all\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_clone"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -r --remote\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_commands"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --update-completion -a --aliases --format --header --update\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_compiler"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"find add remove rm list info\";\
    fi\
","")
set_shell_function("_spack_compiler_add"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_compiler_find"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_compiler_info"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        _installed_compilers;\
    fi\
","")
set_shell_function("_spack_compiler_list"," \
    SPACK_COMPREPLY=\"-h --help --scope\"\
","")
set_shell_function("_spack_compiler_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all --scope\";\
    else\
        _installed_compilers;\
    fi\
","")
set_shell_function("_spack_compiler_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all --scope\";\
    else\
        _installed_compilers;\
    fi\
","")
set_shell_function("_spack_compilers"," \
    SPACK_COMPREPLY=\"-h --help --scope\"\
","")
set_shell_function("_spack_completions"," \
    local COMP_CWORD COMP_KEY COMP_LINE COMP_POINT COMP_TYPE COMP_WORDS COMPREPLY;\
    COMP_LINE=\"$*\";\
    COMP_POINT=${#COMP_LINE};\
    COMP_WORDS=(\"$@\");\
    if [[ ${COMP_LINE: -1} == ' ' ]]; then\
        COMP_WORDS+=('');\
    fi;\
    COMP_CWORD=$((${#COMP_WORDS[@]} - 1));\
    COMP_KEY=9;\
    COMP_TYPE=64;\
    _bash_completion_spack;\
    echo \"${COMPREPLY[@]:-}\"\
","")
set_shell_function("_spack_concretize"," \
    SPACK_COMPREPLY=\"-h --help -f --force --test -q --quiet -U --fresh --reuse --reuse-deps -j --jobs\"\
","")
set_shell_function("_spack_config"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        SPACK_COMPREPLY=\"get blame edit list add prefer-upstream remove rm update revert\";\
    fi\
","")
set_shell_function("_spack_config_add"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -f --file\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_config_blame"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _config_sections;\
    fi\
","")
set_shell_function("_spack_config_edit"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --print-file\";\
    else\
        _config_sections;\
    fi\
","")
set_shell_function("_spack_config_get"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _config_sections;\
    fi\
","")
set_shell_function("_spack_config_list"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_config_prefer_upstream"," \
    SPACK_COMPREPLY=\"-h --help --local\"\
","")
set_shell_function("_spack_config_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_config_revert"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        _config_sections;\
    fi\
","")
set_shell_function("_spack_config_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_config_update"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        _config_sections;\
    fi\
","")
set_shell_function("_spack_containerize"," \
    SPACK_COMPREPLY=\"-h --help --list-os --last-stage\"\
","")
set_shell_function("_spack_create"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --keep-stage -n --name -t --template -r --repo -N --namespace -f --force --skip-editor -b --batch\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_debug"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"create-db-tarball report\";\
    fi\
","")
set_shell_function("_spack_debug_create_db_tarball"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_debug_report"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_dependencies"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -i --installed -t --transitive --deptype -V --no-expand-virtuals\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_dependents"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -i --installed -t --transitive\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_deprecate"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all -d --dependencies -D --no-dependencies -i --install-deprecator -I --no-install-deprecator -l --link-type\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_determine_shell"," \
    if [ -f \"/proc/$$/exe\" ]; then\
        _sp_exe=$(readlink /proc/$$/exe);\
        basename ${_sp_exe} | tr -d '0123456789';\
    else\
        if [ -n \"${BASH:-}\" ]; then\
            echo bash;\
        else\
            if [ -n \"${ZSH_NAME:-}\" ]; then\
                echo zsh;\
            else\
                PS_FORMAT= ps -p $$ | tail -n 1 | awk '{print $4}' | sed 's/^-//' | xargs basename;\
            fi;\
        fi;\
    fi\
","")
set_shell_function("_spack_dev_build"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -j --jobs -d --source-path -i --ignore-dependencies -n --no-checksum --deprecated --keep-prefix --skip-patch -q --quiet --drop-in --test -b --before -u --until --clean --dirty -U --fresh --reuse --reuse-deps\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_develop"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -p --path --no-clone --clone -f --force\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_diff"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --json --first -a --attribute\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_docs"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_edit"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -b --build-system -c --command -d --docs -t --test -m --module -r --repo -N --namespace\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_env"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"activate deactivate create remove rm list ls status st loads view update revert depfile\";\
    fi\
","")
set_shell_function("_spack_env_activate"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --sh --csh --fish --bat --pwsh -v --with-view -V --without-view -p --prompt --temp -d --dir\";\
    else\
        _environments;\
    fi\
","")
set_shell_function("_spack_env_create"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -d --dir --keep-relative --without-view --with-view\";\
    else\
        _environments;\
    fi\
","")
set_shell_function("_spack_env_deactivate"," \
    SPACK_COMPREPLY=\"-h --help --sh --csh --fish --bat\"\
","")
set_shell_function("_spack_env_depfile"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --make-prefix --make-target-prefix --make-disable-jobserver --use-buildcache -o --output -G --generator\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_env_list"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_env_loads"," \
    SPACK_COMPREPLY=\"-h --help -n --module-set-name -m --module-type --input-only -p --prefix -x --exclude -r --dependencies\"\
","")
set_shell_function("_spack_env_ls"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_env_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        _environments;\
    fi\
","")
set_shell_function("_spack_env_revert"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        _environments;\
    fi\
","")
set_shell_function("_spack_env_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        _environments;\
    fi\
","")
set_shell_function("_spack_env_st"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_env_status"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_env_update"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        _environments;\
    fi\
","")
set_shell_function("_spack_env_view"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_extensions"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -l --long -L --very-long -d --deps -p --paths -s --show\";\
    else\
        _extensions;\
    fi\
","")
set_shell_function("_spack_external"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"find list read-cray-manifest\";\
    fi\
","")
set_shell_function("_spack_external_find"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --not-buildable --exclude -p --path --scope --all -t --tag\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_external_list"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_external_read_cray_manifest"," \
    SPACK_COMPREPLY=\"-h --help --file --directory --ignore-default-dir --dry-run --fail-on-error\"\
","")
set_shell_function("_spack_fetch"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -n --no-checksum --deprecated -m --missing -D --dependencies\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_find"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --format -H --hashes --json -d --deps -p --paths --groups --no-groups -l --long -L --very-long -t --tag -N --namespaces -c --show-concretized -f --show-flags --show-full-compiler -x --explicit -X --implicit -u --unknown -m --missing -v --variants --loaded -M --only-missing --deprecated --only-deprecated --start-date --end-date\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_fn_exists"," \
    LANG= type $1 2>&1 | grep -q 'function'\
","")
set_shell_function("_spack_gc"," \
    SPACK_COMPREPLY=\"-h --help -y --yes-to-all\"\
","")
set_shell_function("_spack_gpg"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"verify trust untrust sign create list init export publish\";\
    fi\
","")
set_shell_function("_spack_gpg_create"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --comment --expires --export --export-secret\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_gpg_export"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --secret\";\
    else\
        _keys;\
    fi\
","")
set_shell_function("_spack_gpg_init"," \
    SPACK_COMPREPLY=\"-h --help --from\"\
","")
set_shell_function("_spack_gpg_list"," \
    SPACK_COMPREPLY=\"-h --help --trusted --signing\"\
","")
set_shell_function("_spack_gpg_publish"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -d --directory -m --mirror-name --mirror-url --rebuild-index\";\
    else\
        _keys;\
    fi\
","")
set_shell_function("_spack_gpg_sign"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --output --key --clearsign\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_gpg_trust"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_gpg_untrust"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --signing\";\
    else\
        _keys;\
    fi\
","")
set_shell_function("_spack_gpg_verify"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_graph"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --ascii -d --dot -s --static -c --color -i --installed --deptype\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_help"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all --spec\";\
    else\
        _subcommands;\
    fi\
","")
set_shell_function("_spack_info"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all --detectable --maintainers --no-dependencies --no-variants --no-versions --phases --tags --tests --virtuals\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_install"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --only -u --until -j --jobs --overwrite --fail-fast --keep-prefix --keep-stage --dont-restage --use-cache --no-cache --cache-only --use-buildcache --include-build-deps --no-check-signature --show-log-on-error --source -n --no-checksum --deprecated -v --verbose --fake --only-concrete --add --no-add -f --file --clean --dirty --test --log-format --log-file --help-cdash --cdash-upload-url --cdash-build --cdash-site --cdash-track --cdash-buildstamp -y --yes-to-all -U --fresh --reuse --reuse-deps\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_license"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --root\";\
    else\
        SPACK_COMPREPLY=\"list-files verify update-copyright-year\";\
    fi\
","")
set_shell_function("_spack_license_list_files"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_license_update_copyright_year"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_license_verify"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_list"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -d --search-description --format -v --virtuals -t --tag --count --update\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_load"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --sh --csh --fish --bat --first --only --list\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_location"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -m --module-dir -r --spack-root -i --install-dir -p --package-dir -P --packages -s --stage-dir -S --stages --source-dir -b --build-dir -e --env --first\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_log_parse"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --show -c --context -p --profile -w --width -j --jobs\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_maintainers"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --maintained --unmaintained -a --all --by-user\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_make_installer"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -v --spack-version -s --spack-source -g --git-installer-verbosity\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_mark"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all -e --explicit -i --implicit\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_mirror"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -n --no-checksum --deprecated\";\
    else\
        SPACK_COMPREPLY=\"create destroy add remove rm set-url set list\";\
    fi\
","")
set_shell_function("_spack_mirror_add"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope --type --s3-access-key-id --s3-access-key-secret --s3-access-token --s3-profile --s3-endpoint-url\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_mirror_create"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -d --directory -a --all -f --file --exclude-file --exclude-specs --skip-unstable-versions -D --dependencies -n --versions-per-spec\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_mirror_destroy"," \
    SPACK_COMPREPLY=\"-h --help -m --mirror-name --mirror-url\"\
","")
set_shell_function("_spack_mirror_list"," \
    SPACK_COMPREPLY=\"-h --help --scope\"\
","")
set_shell_function("_spack_mirror_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_mirror_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_mirror_set"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --push --fetch --type --url --scope --s3-access-key-id --s3-access-key-secret --s3-access-token --s3-profile --s3-endpoint-url\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_mirror_set_url"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --push --fetch --scope --s3-access-key-id --s3-access-key-secret --s3-access-token --s3-profile --s3-endpoint-url\";\
    else\
        _mirrors;\
    fi\
","")
set_shell_function("_spack_module"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"lmod tcl\";\
    fi\
","")
set_shell_function("_spack_module_lmod"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -n --name\";\
    else\
        SPACK_COMPREPLY=\"refresh find rm loads setdefault\";\
    fi\
","")
set_shell_function("_spack_module_lmod_find"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --full-path -r --dependencies\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_lmod_loads"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --input-only -p --prefix -x --exclude -r --dependencies\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_lmod_refresh"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --delete-tree --upstream-modules -y --yes-to-all\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_lmod_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_lmod_setdefault"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_tcl"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -n --name\";\
    else\
        SPACK_COMPREPLY=\"refresh find rm loads setdefault\";\
    fi\
","")
set_shell_function("_spack_module_tcl_find"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --full-path -r --dependencies\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_tcl_loads"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --input-only -p --prefix -x --exclude -r --dependencies\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_tcl_refresh"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --delete-tree --upstream-modules -y --yes-to-all\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_tcl_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_module_tcl_setdefault"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_patch"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -n --no-checksum --deprecated -U --fresh --reuse --reuse-deps\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_pathadd"," \
    _pa_varname=PATH;\
    _pa_new_path=\"$1\";\
    if [ -n \"$2\" ]; then\
        _pa_varname=\"$1\";\
        _pa_new_path=\"$2\";\
    fi;\
    eval \"_pa_oldvalue=\\${${_pa_varname}:-}\";\
    _pa_canonical=\":$_pa_oldvalue:\";\
    if [ -d \"$_pa_new_path\" ] && [ \"${_pa_canonical#*:${_pa_new_path}:}\" = \"${_pa_canonical}\" ]; then\
        if [ -n \"$_pa_oldvalue\" ]; then\
            eval \"export $_pa_varname=\\\"$_pa_new_path:$_pa_oldvalue\\\"\";\
        else\
            export $_pa_varname=\"$_pa_new_path\";\
        fi;\
    fi\
","")
set_shell_function("_spack_pkg"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"add list diff added changed removed grep source hash\";\
    fi\
","")
set_shell_function("_spack_pkg_add"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_pkg_added"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_pkg_changed"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -t --type\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_pkg_diff"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_pkg_grep"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"--help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_pkg_hash"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_pkg_list"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_pkg_removed"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_pkg_source"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -c --canonical\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_providers"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _providers;\
    fi\
","")
set_shell_function("_spack_pydoc"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_python"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -V --version -c -u -i -m --path\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_reindex"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all -l --list-name -f --force\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_repo"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"create list add remove rm\";\
    fi\
","")
set_shell_function("_spack_repo_add"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_repo_create"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -d --subdirectory\";\
    else\
        _repos;\
    fi\
","")
set_shell_function("_spack_repo_list"," \
    SPACK_COMPREPLY=\"-h --help --scope\"\
","")
set_shell_function("_spack_repo_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        _repos;\
    fi\
","")
set_shell_function("_spack_repo_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --scope\";\
    else\
        _repos;\
    fi\
","")
set_shell_function("_spack_resource"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"list show\";\
    fi\
","")
set_shell_function("_spack_resource_list"," \
    SPACK_COMPREPLY=\"-h --help --only-hashes\"\
","")
set_shell_function("_spack_resource_show"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _all_resource_hashes;\
    fi\
","")
set_shell_function("_spack_restage"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all -l --list-name -f --force\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_shell_wrapper"," \
    for var in DYLD_LIBRARY_PATH DYLD_FALLBACK_LIBRARY_PATH;\
    do\
        eval \"if [ -n \\\"\\${${var}-}\\\" ]; then export SPACK_$var=\\${${var}}; fi\";\
    done;\
    if [ -n \"${ZSH_VERSION:-}\" ]; then\
        emulate -L sh;\
    fi;\
    _sp_flags=\"\";\
    while [ ! -z ${1+x} ] && [ \"${1#-}\" != \"${1}\" ]; do\
        _sp_flags=\"$_sp_flags $1\";\
        shift;\
    done;\
    if [ -n \"$_sp_flags\" ] && [ \"${_sp_flags#*h}\" != \"${_sp_flags}\" ] || [ \"${_sp_flags#*V}\" != \"${_sp_flags}\" ]; then\
        command spack $_sp_flags \"$@\";\
        return;\
    fi;\
    _sp_subcommand=\"\";\
    if [ ! -z ${1+x} ]; then\
        _sp_subcommand=\"$1\";\
        shift;\
    fi;\
    case $_sp_subcommand in \
        \"cd\")\
            _sp_arg=\"\";\
            if [ -n \"$1\" ]; then\
                _sp_arg=\"$1\";\
                shift;\
            fi;\
            if [ \"$_sp_arg\" = \"-h\" ] || [ \"$_sp_arg\" = \"--help\" ]; then\
                command spack cd -h;\
            else\
                LOC=\"$(spack location $_sp_arg \"$@\")\";\
                if [ -d \"$LOC\" ]; then\
                    cd \"$LOC\";\
                else\
                    return 1;\
                fi;\
            fi;\
            return\
        ;;\
        \"env\")\
            _sp_arg=\"\";\
            if [ -n \"$1\" ]; then\
                _sp_arg=\"$1\";\
                shift;\
            fi;\
            if [ \"$_sp_arg\" = \"-h\" ] || [ \"$_sp_arg\" = \"--help\" ]; then\
                command spack env -h;\
            else\
                case $_sp_arg in \
                    activate)\
                        _a=\" $@\";\
                        if [ -z ${1+x} ] || [ \"${_a#* --sh}\" != \"$_a\" ] || [ \"${_a#* --csh}\" != \"$_a\" ] || [ \"${_a#* -h}\" != \"$_a\" ] || [ \"${_a#* --help}\" != \"$_a\" ]; then\
                            command spack env activate \"$@\";\
                        else\
                            stdout=\"$(command spack $_sp_flags env activate --sh \"$@\")\" || return;\
                            eval \"$stdout\";\
                        fi\
                    ;;\
                    deactivate)\
                        _a=\" $@\";\
                        if [ \"${_a#* --sh}\" != \"$_a\" ] || [ \"${_a#* --csh}\" != \"$_a\" ]; then\
                            command spack env deactivate \"$@\";\
                        else\
                            if [ -n \"$*\" ]; then\
                                command spack env deactivate -h;\
                            else\
                                stdout=\"$(command spack $_sp_flags env deactivate --sh)\" || return;\
                                eval \"$stdout\";\
                            fi;\
                        fi\
                    ;;\
                    *)\
                        command spack env $_sp_arg \"$@\"\
                    ;;\
                esac;\
            fi;\
            return\
        ;;\
        \"load\" | \"unload\")\
            _a=\" $@\";\
            if [ \"${_a#* --sh}\" != \"$_a\" ] || [ \"${_a#* --csh}\" != \"$_a\" ] || [ \"${_a#* -h}\" != \"$_a\" ] || [ \"${_a#* --list}\" != \"$_a\" ] || [ \"${_a#* --help}\" != \"$_a\" ]; then\
                command spack $_sp_flags $_sp_subcommand \"$@\";\
            else\
                stdout=\"$(command spack $_sp_flags $_sp_subcommand --sh \"$@\")\" || return;\
                eval \"$stdout\";\
            fi\
        ;;\
        *)\
            command spack $_sp_flags $_sp_subcommand \"$@\"\
        ;;\
    esac\
","")
set_shell_function("_spack_solve"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --show -l --long -L --very-long -N --namespaces -I --install-status --no-install-status -y --yaml -j --json -c --cover -t --types --timers --stats -U --fresh --reuse --reuse-deps\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_spec"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -l --long -L --very-long -N --namespaces -I --install-status --no-install-status -y --yaml -j --json --format -c --cover -t --types -U --fresh --reuse --reuse-deps\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_stage"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -n --no-checksum --deprecated -p --path -U --fresh --reuse --reuse-deps\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_style"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -b --base -a --all -r --root-relative -U --no-untracked -f --fix --root -t --tool -s --skip\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_tags"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -i --installed -a --all\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_test"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"run list find status results remove\";\
    fi\
","")
set_shell_function("_spack_test_env"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --clean --dirty -U --fresh --reuse --reuse-deps --dump --pickle\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_test_find"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_test_list"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_test_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -y --yes-to-all\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_test_results"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -l --logs -f --failed\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_test_run"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --alias --fail-fast --fail-first --externals -x --explicit --keep-stage --log-format --log-file --cdash-upload-url --cdash-build --cdash-site --cdash-track --cdash-buildstamp --help-cdash --clean --dirty\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_test_status"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_tutorial"," \
    SPACK_COMPREPLY=\"-h --help -y --yes-to-all\"\
","")
set_shell_function("_spack_undevelop"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -a --all\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_uninstall"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -f --force --remove -R --dependents -y --yes-to-all -a --all --origin\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_unit_test"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -H --pytest-help -l --list -L --list-long -N --list-names --extension -s -k --showlocals\";\
    else\
        _unit_tests;\
    fi\
","")
set_shell_function("_spack_unload"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --sh --csh --fish --bat -a --all\";\
    else\
        _installed_packages;\
    fi\
","")
set_shell_function("_spack_url"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        SPACK_COMPREPLY=\"parse list summary stats\";\
    fi\
","")
set_shell_function("_spack_url_list"," \
    SPACK_COMPREPLY=\"-h --help -c --color -e --extrapolation -n --incorrect-name -N --correct-name -v --incorrect-version -V --correct-version\"\
","")
set_shell_function("_spack_url_parse"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -s --spider\";\
    else\
        SPACK_COMPREPLY=\"\";\
    fi\
","")
set_shell_function("_spack_url_stats"," \
    SPACK_COMPREPLY=\"-h --help --show-issues\"\
","")
set_shell_function("_spack_url_summary"," \
    SPACK_COMPREPLY=\"-h --help\"\
","")
set_shell_function("_spack_verify"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -l --local -j --json -a --all -s --specs -f --files\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_versions"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -s --safe --safe-only -r --remote -n --new -c --concurrency\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help -v --verbose -e --exclude -d --dependencies\";\
    else\
        SPACK_COMPREPLY=\"symlink add soft hardlink hard copy relocate remove rm statlink status check\";\
    fi\
","")
set_shell_function("_spack_view_add"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --projection-file -i --ignore-conflicts\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_check"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_copy"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --projection-file -i --ignore-conflicts\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_hard"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --projection-file -i --ignore-conflicts\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_hardlink"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --projection-file -i --ignore-conflicts\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_relocate"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --projection-file -i --ignore-conflicts\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_remove"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --no-remove-dependents -a --all\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_rm"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --no-remove-dependents -a --all\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_soft"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --projection-file -i --ignore-conflicts\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_statlink"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_status"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spack_view_symlink"," \
    if $list_options; then\
        SPACK_COMPREPLY=\"-h --help --projection-file -i --ignore-conflicts\";\
    else\
        _all_packages;\
    fi\
","")
set_shell_function("_spacktivate"," \
    _spack_env_activate\
","")
set_shell_function("_subcommands"," \
    if [[ -z \"${SPACK_SUBCOMMANDS:-}\" ]]; then\
        SPACK_SUBCOMMANDS=\"$(spack commands)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_SUBCOMMANDS\"\
","")
set_shell_function("_test_vars"," \
    echo \"-----------------------------------------------------\";\
    echo \"Variables set by bash:\";\
    echo;\
    echo \"COMP_LINE:                '$COMP_LINE'\";\
    echo \"# COMP_LINE:              '${#COMP_LINE}'\";\
    echo \"COMP_WORDS:               $(_pretty_print COMP_WORDS[@])\";\
    echo \"# COMP_WORDS:             '${#COMP_WORDS[@]}'\";\
    echo \"COMP_CWORD:               '$COMP_CWORD'\";\
    echo \"COMP_KEY:                 '$COMP_KEY'\";\
    echo \"COMP_POINT:               '$COMP_POINT'\";\
    echo \"COMP_TYPE:                '$COMP_TYPE'\";\
    echo \"COMP_WORDBREAKS:          '$COMP_WORDBREAKS'\";\
    echo;\
    echo \"Intermediate variables:\";\
    echo;\
    echo \"COMP_WORDS_NO_FLAGS:      $(_pretty_print COMP_WORDS_NO_FLAGS[@])\";\
    echo \"# COMP_WORDS_NO_FLAGS:    '${#COMP_WORDS_NO_FLAGS[@]}'\";\
    echo \"COMP_CWORD_NO_FLAGS:      '$COMP_CWORD_NO_FLAGS'\";\
    echo;\
    echo \"Subfunction:              '$subfunction'\";\
    if $list_options; then\
        echo \"List options:             'True'\";\
    else\
        echo \"List options:             'False'\";\
    fi;\
    echo \"Current word:             '$cur'\"\
","")
set_shell_function("_unit_tests"," \
    if [[ -z \"${SPACK_TESTS:-}\" ]]; then\
        SPACK_TESTS=\"$(spack unit-test -l)\";\
    fi;\
    SPACK_COMPREPLY=\"$SPACK_TESTS\"\
","")
set_shell_function("spack"," \
    : this is a shell function from: /Users/mathomp4/spack-mathomp4/share/spack/setup-env.sh;\
    : the real spack script is here: /Users/mathomp4/spack-mathomp4/bin/spack;\
    _spack_shell_wrapper \"$@\";\
    return $?\
","")
complete("bash","spack","-o bashdefault -o default -F _bash_completion_spack")
complete("bash","spacktivate","-o bashdefault -o default -F _bash_completion_spack")
