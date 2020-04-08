# Rime configuration

[Rime] is a Chinese input method

I assume you know Chinese if you're planning to read this document

[rime]: https://rime.im/

# Enable input methods

- 速成（有大改過，唔係 upstream 版本）
- 廣東話

# System requirements

- Rime
- Frontend for rime depending on your system. Such as ibus

Following schemas （配方/輸入方案） are also required. May installed with [plum] or system
package manager. In arch, install with `pacman`.

[plum]: https://github.com/rime/plum

- [rime-cantonese](https://github.com/rime/rime-cantonese)
- [rime-emoji](https://github.com/rime/rime-emoji)

# Features (Compare to official schemas)

- ［All］Extended with user's phrases (See [Custom phrases](#custom-phrases) section)
- ［速成］廣東話字詞（source: 廣東話配方）
- ［速成］廣東話反查倉頡（`Z`制）
- ［速成］Emoji suggestion
- ［速成］包含倉頡 3、倉頡 5 碼表
- ［廣東話］懶音輸入

# 生成速成廣東話詞庫 (Build step)

廣東話字典入面有啲字係包含拼音嘅，但係又係字詞嘅就要特別 extract 出嚟用

主要文件：[`jyut6ping3.dict.yaml`](https://github.com/rime/rime-cantonese/blob/master/jyut6ping3.dict.yaml)

製作方法

1. Download 個 file
2. Del 咗單字嗰 part 同埋最頂嘅 yaml
3. 將拼音 part 削除 (vim command: `%s/\t.*$//g`)
4. 將結果 replace 落 `jyut6ping3.words.dict.yaml`

個 file 好多字，結果 editor 比較多 plugin 嘅話記得 disable 先開

# Known issues

- ［速成］廣東話反查送字不能
- ［速成］廣東話反查`-` 返唔到上一頁

# TODO (Or never do)

- ［廣東話］加入速成反查
- ［速成］直接 source 廣東話詞庫，削除 build step

# Custom phrases

Append custom phrases to bottom of file `custom_phrase.dict.yaml`. Then re-deploy
