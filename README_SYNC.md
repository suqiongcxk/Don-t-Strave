# 饥荒存档同步

仓库：<https://github.com/suqiongcxk/Don-t-Strave>

## 首次上传

1. 安装 Git for Windows。
2. 在这个存档目录打开 VS Code 终端。
3. 执行：

   ```powershell
   Set-ExecutionPolicy -Scope Process Bypass
   .\sync_to_github.ps1
   ```

## 两台电脑同步

游玩前先执行：

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\sync_to_github.ps1 -Pull
```

退出游戏后执行：

```powershell
.\sync_to_github.ps1
```

不要在两台电脑同时游玩后再推送；先退出游戏并推送，再在另一台电脑拉取。
