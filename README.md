#oh-my-config

## 1. vim-config

使用vim半年多之后，经过多次选择和尝试总结出来的暂时解毒的配置

### 1.1 原则

尽量少的插件，尽量简单实用的配置

### 1.2 插件

1. vim-plug
2. neocomplete.vim
3. nerdtree
4. tagbar
5. fcitx.vim
6. emmet
7. vim-gitgutter
8. vim-markdown
9. vim-airline
10. vim-airline-themes
11. ale

### 1.3 vim补全配置

vim补全采用字典补全的方式，配合neocomplete可以自动弹出补全列表

优点：
1. 补全字典的关键字保存在文件中，可以随时根据需要增加和删除
2. 避免安装过多的插件
3. 不用开启vim的python支持等，安装linux软件源中的vim-gtk3即可直接使用
4. 补全速度相对来说可以接受，python字典有十多万行时才显得有点点卡

#### 1.3.1 为什么不使用其他补全

1. ycm太臃肿，而且需要python支持，懒得自己编译(不喜勿喷)
2. 其他针对不用语言的补全插件比如pydiction，omniCppComplete等插件如果每种语言都安装一个补全插件的话会使插件过多
3. 或许还有其他未尝试的方式？

#### 1.3.2 现在已经整理好的字典

1. python：直接使用pydiction的字典，十多万行，弹出补全列表时有点点卡顿
2. c： linux c 
3. c++：c++ ， qt5

字典关键词的获取可以使用爬虫等多种方式

## 2. fonts-config

一些好用的开源字体和powerline字体

## 3. bash-config

oh-my-zsh 启动有些卡，所以换回bash，并在其中寻求满足需要的设置

## 4. awesome-config

awesome桌面的设置