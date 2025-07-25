player=$(playerctl metadata --format "{{xesam:url}}" 2>/dev/null | awk -F '/' '{ print $3 }')

declare -A icons
icons[spotify]=""
icons[youtube]=""
icons[stopped]="󰝛"
icons[default]=""

icon=${icons[default]}

[[ -z "$player" ]] && icon=${icons[stopped]} 
[[ "$player" =~ [Ss]potify ]] && icon=${icons[spotify]} 
[[ "$player" =~ [Yy]outube ]] && icon=${icons[youtube]} 

echo "$icon"
