$str = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" # 使用する文字列
$maxDigits = 3 # 生成する最大桁数

# 入力値の検証
if (($maxDigits -le 0) -or ($maxDigits -gt $str.Length) -or ($maxDigits -ne [int]$maxDigits)) {
    Write-Error "桁指定は1以上、$($str.Length)以下の整数で指定してください。"
    exit
}

$strLength = $str.Length # 文字列の長さ
$maxIndex = $strLength - 1 # 最大インデックス

# 1桁から最大桁数までループ
for ($currentDigits = 1; $currentDigits -le $maxDigits; $currentDigits++) {
    Write-Host "--- $($currentDigits)桁のパスワード生成 ---"
    $indices = @(0) * $currentDigits # 現在の桁数のインデックスを格納する配列

    while ($true) {
        $output = ""
        for ($i = 0; $i -lt $currentDigits; $i++) {
            $output += $str[$indices[$i]] # 現在のインデックスに対応する文字を追加
        }
        Write-Host $output

        # インデックスを更新
        $indices[$currentDigits - 1]++ # 最後の桁をインクリメント

        $carry = $false # 繰り上がりが発生したかどうかのフラグ
        for ($i = $currentDigits - 1; $i -ge 0; $i--) { # 右から左へ（最後の桁から順に）処理
            if ($indices[$i] -gt $maxIndex) { # 現在の桁が最大値を超えた場合
                $indices[$i] = 0 # 現在の桁をリセット
                if ($i -gt 0) {
                    $indices[$i - 1]++ # 前の桁をインクリメント
                } else {
                    $carry = $true # 最上位の桁で繰り上がりが発生
                }
            } else {
                break # 繰り上がりがなければループを抜ける
            }
        }

        # 全ての組み合わせを生成したら終了
        if ($carry) {
            break # 最上位桁で繰り上がりが発生したら、その桁数での生成は完了
        }
    }
}