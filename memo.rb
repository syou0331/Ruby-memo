require 'csv'
#１．関数定義
#１－１ファイル操作判定関数
def judgeOperation(memo_mode)
    if memo_mode == 1
        createMemo()
    elsif memo_mode == 2
        puts "編集したいファイル名を入力して下さい（拡張子除く）"
        editMemo()
    else
    puts "入力に誤りがあります。\n \"1\"または\"2\"を、半角で入力して下さい。"
    memo_mode = gets.to_i
    judgeOperation(memo_mode)
    end
end

#１－２新規メモ作成処理
def createMemo
    puts "新規作成するファイル名を入力して下さい（拡張子除く）"
    file_name = gets.chomp + ".csv"
    puts "メモしたい内容を入力して下さい\n完了したら Ctrl + D を押します。"

    memo_type = $stdin.readlines
    CSV.open("#{file_name}", "w", ) do |csv|
        csv.puts ["#{memo_type}"]
    end
    puts "csvファイルを新規作成しました。"
end

#１－３既存メモ編集処理
def editMemo
    memo_completed = false
    file_name = gets.chomp + ".csv"
    
    #入力されたファイルが見つからない場合、再度ファイル名の入力を促す
    if File.exists?("./#{file_name}") == false
        puts "ファイルが見つかりません。\n再度、ファイル名を入力して下さい（拡張子除く）"
        editMemo()
        memo_completed = true
    end

    if memo_completed == false
        puts "メモしたい内容を入力して下さい(内容は先頭から追記されます。)\n 完了したら Ctrl + D を押します"
        memo_type = $stdin.readlines
        CSV.open("#{file_name}", "r+", ) do |csv|
            csv.puts ["#{memo_type}"]
        end
        puts "csvファイルを編集しました。"
    end
end

#2.メイン処理
puts "-----------------------------------------------"
puts "これはメモアプリです。\n入力された文字列を、csvファイルとして出力します。"
puts "-----------------------------------------------"
puts "ファイルの操作を選択して下さい。\n1:新規メモの作成 2:既存メモの編集"

memo_mode = gets.to_i

judgeOperation(memo_mode)

puts "メモアプリを終了します"