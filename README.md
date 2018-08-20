# firstflutter

A new Flutter project.

## Getting Started
 ####快捷键
    1.快速生成无状态的控件：stless
    2.快速生成有状态的控件：stful
##### StatelessWidget
    所有的值都是不可改变的，值都是finalde 
##### MaterialApp
    MaterialApp：在无状态的build方法中返回，同时有title属性：在任务管理器中显示当前的名字,home属性：配置脚手架scaffold的
##### scaffold
    scaffold：脚手架，写在MaterialApp的home属性中，属性appBar:配置appBar的，属性body:配置页面的各种内容，通常是返回一个新的继承者StatelessWidget或者StateFullWidget的控件