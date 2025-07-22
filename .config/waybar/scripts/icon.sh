player=$(playerctl metadata --format "{{xesam:url}}" | awk -F '/' '{ print $3 }')

declare -A icons
icons[spotify]=""
icons[youtube]=""
icons[default]="🎜"

icon=${icons[default]}

[[ "$player" =~ [Ss]potify ]] && icon=${icons[spotify]} 
[[ "$player" =~ [Yy]outube ]] && icon=${icons[youtube]} 

echo "$icon "
