player=$(playerctl metadata --format "{{xesam:url}}" | awk -F '/' '{ print $3 }')
[[ "$player" =~ [Ss]potify ]] 
