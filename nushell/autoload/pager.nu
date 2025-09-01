$env.PAGER = 'less'
$env.LESS = '-SFXR'

# Use `bat` as pager for `man`
# Ref: https://github.com/sharkdp/bat?tab=readme-ov-file#man
$env.MANPAGER = r#'nu --stdin -c '$in | str replace -a -r ".\u{8}" "" | ansi strip | bat -p -lman''#
