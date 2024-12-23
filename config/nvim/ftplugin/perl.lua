----------------------------------------------------
-- perl settings
----------------------------------------------------

vim.g.perl_sub_signatures = 1

-- 関数: 外部コマンドを実行して結果を取得
local function exec_cmd(cmd)
  local handle = io.popen(cmd)
  if not handle then
    return nil
  end
  local result = handle:read("*a"):gsub("%s+$", "") -- 改行を削除
  handle:close()
  return result
end

-- Perl の archname を取得
local perl_arch = exec_cmd('perl -MConfig -e "print \\$Config{archname}"')
if not perl_arch then
  vim.notify("Failed to get Perl archname", vim.log.levels.ERROR)
  return
end

-- Perl のライブラリパスを取得
local perl_lib = exec_cmd('which perl | perl -pe "s!([^/]+)/bin/perl\n!\\$1/lib/\\$1!"')
if not perl_lib then
  vim.notify("Failed to get Perl library path", vim.log.levels.ERROR)
  return
end

local perl_lib_arch = perl_lib .. "/" .. perl_arch

-- Carmel 環境がある場合のpathを設定
if vim.fn.isdirectory(".carmel") == 1 then
  local perl_carmel = exec_cmd('env PERL5OPT="-MCarmel::Setup" perl -e "print join \',\', @{\\$Carmel::MySetup::environment{inc}}"')
  if perl_carmel then
    vim.opt_local.path:append(perl_carmel)
  else
    vim.notify("Failed to get Carmel environment paths", vim.log.levels.WARN)
  end
end

-- その他のpathを設定
local additional_paths = {
  "lib",
  "t/lib",
  "blib/lib",
  "blib/arch",
  "extlib",
  "local/lib/perl5",
  "local/lib/perl5/" .. perl_arch,
  perl_lib,
  perl_lib_arch,
  "./",
}

vim.opt_local.path:append(table.concat(additional_paths, ","))
