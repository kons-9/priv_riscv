# 設定の書き方
設定は`toml`を使って書きます。`config.toml`に保存してください。

実行ファイルの設定例:
```toml
name = "file_name"
extension = "svh"
description = "SystemVerilog Header File"
flag = "exec"
[int]
PRIME_NUM = 57

[str]
PRIME_STR = "Hello, World!"

[define]
```

テストディレクトリの設定例:
```toml
name = "file_name"
extension = "svh"
description = "SystemVerilog Header File"
flag = "test"

# 共通の設定
[common.int]
PRIME_NUM = 57
[common.str]
PRIME_STR = "Hello, World!"
[common.define]

# 各テストの設定
[[tests]]
name = "test_name"
[tests.int]
TEST_NUM = 42
[tests.str]
TEST_STR = "test 1"
[tests.define]

[[tests]]
name = "test_name2"
[tests.int]
TEST_NUM = 100
[tests.str]
TEST_STR = "test 2"
[tests.define]
```
