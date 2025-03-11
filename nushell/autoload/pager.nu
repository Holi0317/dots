$env.PAGER = 'less'
$env.LESS = '-SFXR'

# Use `bat` as pager for `man`
# Ref: https://github.com/sharkdp/bat?tab=readme-ov-file#man
$env.MANPAGER = "nu --stdin -c 'ansi strip | bat -p -lman'"
