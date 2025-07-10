#!/usr/bin/env bash
CONFIG_FILE="/home/container/config.yml"

cd /home/container

cat << EOF > $CONFIG_FILE
# Sometimes dependencies change in ways that break screeps-launcher or the builds it does.  To work around those issues, some package versions need to be pinned.  See the current list in the README at https://github.com/screepers/screeps-launcher/ or the specific issue tracking pinned packages: https://github.com/screepers/screeps-launcher/issues/34
pinnedPackages:
  ssri: 8.0.1
  cacache: 15.3.0
  passport-steam: 1.0.17
  minipass-fetch: 2.1.2
  express-rate-limit: 6.7.0
EOF

if [[ -n "${MODS_LIST}" ]]; then
    echo "mods:" >> $CONFIG_FILE

    normalized_mods=${MODS_LIST//, /,}
    IFS=',' read -ra mod_array <<< "$normalized_mods"
    for mod in "${mod_array[@]}"; do
        echo "- $mod" >> $CONFIG_FILE
    done
fi

if [[ -n "${BOTS_LIST}" ]]; then
    echo "bots:" >> $CONFIG_FILE
    normalized_bots=${BOTS_LIST//, /,}
    IFS=',' read -ra bot_array <<< "$normalized_bots"
    for bot_pair in "${bot_array[@]}"; do
        echo "  $bot_pair" >> $CONFIG_FILE
    done
fi

if [[ -n "${WELCOME_TEXT}" || -n "${TICK_RATE}" ]]; then
    echo "serverConfig:" >> $CONFIG_FILE
    if [[ -n "${WELCOME_TEXT}" ]]; then
        echo "  welcomeText:  |" >> $CONFIG_FILE
        while IFS= read -r line; do
            echo"    ${line}" >> $CONFIG_FILE
        done <<< "$WELCOME_TEXT"
    fi

    if [[ -n "${TICK_RATE}" ]]; then
        echo "  tickRate: $TICK_RATE" >> $CONFIG_FILE
    fi
fi

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

${MODIFIED_STARTUP}