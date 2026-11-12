https://docs.gtk.org/gtk3/css-overview.html

|写法|怎么读|
|---|---|
|`*`|选中所有节点。你的配置用它设置默认字体和颜色。|
|`button`|选中所有按钮节点，例如工作区按钮和任务栏按钮。|
|`button:hover`|选中当前鼠标悬停的按钮。`:hover` 表示悬停状态。|
|`tooltip box`|选中提示框里面的 `box`。中间的空格表示「里面的」。|
|`#workspaces button`|选中工作区模块里面的按钮。`#workspaces` 按 ID 找到工作区模块。|
|`.module`|选中带有 `module` 类的节点。`.` 后面是类名。|
|`#clock.time`|选中 ID 是 `clock`、同时带有 `time` 类的节点。两段之间没有空格，所以要求**同一个节点**满足两个条件。|
|`#waybar > box`|选中 `#waybar` 的**直接子节点** `box`。`>` 比空格多了一层限制。|
|`#workspaces button.active label`|选中工作区里**活跃按钮内部**的标签。读复杂选择器时，可以先看最右边，确定最终改的是谁。|

逗号可以让多个选择器共用一套设置。例如 `button, tooltip { ... }` 表示按钮和提示框分别应用花括号里的声明。
