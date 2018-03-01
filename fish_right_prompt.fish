set budspencer_colors 000000 333333 666666 ffffff ffff00 ff6600 ff0000 ff0033 3300ff 0000ff 00ffff 00ff00

function __dann1_prompt_pwd -d 'Displays the present working directory'
  function __dann1_path_segment -S -a current_dir -d 'Display a shortened form of a directory'
    set -l bg_color $budspencer_colors[2]
    set -l fg_color $budspencer_colors[2]

    if not [ -w "$current_dir" ]
      set bg_color $__bobthefish_dk_red
      set fg_color $__bobthefish_lt_red
    end

    __bobthefish_start_segment $bg_color $fg_color

    set -l parent    (dirname "$current_dir")
    set -l directory (basename "$current_dir")    

    if test $current_dir = "/"
      set_color FF0000 --bold
      echo -ns "/"
    else if test $parent = "/"
      set_color 00FF00 --bold
      echo -n "/"
      set_color FF0000 --bold
      echo -ns $directory"/"
    else
      set_color 00FF00 --bold
      echo -n $parent"/"
      set_color FF0000 --bold
      echo -ns $directory"/"
    end
   
  end

  __dann1_path_segment "$PWD"
  set_color normal
end


########################################################################
function __dann1_cmd_duration
  set_color $fish_color_autosuggestion
  set -l cmd_duration (expr $CMD_DURATION / 1000)
  if [ $cmd_duration -gt 0 ]
    set -l seconds ''
    set -l minutes ''
    set -l hours ''
    set -l days ''
    echo -n '' 
    set seconds (expr $cmd_duration \% 68400 \% 3600 \% 60)'s'
    if [ $cmd_duration -ge 60 ]
      set minutes (expr $cmd_duration \% 68400 \% 3600 / 60)'m'
      if [ $cmd_duration -ge 3600 ]
        set hours (expr $cmd_duration \% 68400 / 3600)'h'
        if [ $cmd_duration -ge 68400 ]
          set days (expr $cmd_duration / 68400)'d'
        end
      end
    end
    if [ $status -ne 0 ]
      echo -n (set_color -b $budspencer_colors[2] $budspencer_colors[7])''$days$hours$minutes$seconds' '
    else
      echo -n (set_color -b $budspencer_colors[2] $budspencer_colors[12])''$days$hours$minutes$seconds' '
    end
    set_color normal
  end
end

function fish_battery_prompt
  # if test $BATTERY_PCT -lt 60
  #   set_color $budspencer_colors[4]
  # else if test $BATTERY_PCT -lt 20
  #   set_color $budspencer_colors[6]
  # else
  #   set_color $budspencer_colors[12]
  # end
  # set_color -b $budspencer_colors[2]
  # echo -n $BATTERY_PCT
end

function fish_right_prompt -d 'bobthefish is all about the right prompt'
  __dann1_cmd_duration
  fish_battery_prompt
  set_color normal
end











