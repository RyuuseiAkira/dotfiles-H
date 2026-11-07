#!/bin/sh

governor=$(cpufreqctl.auto-cpufreq -g | tr ' ' '\n' | head -n 1)

text_icon="?" #default

case $governor in
    "performance")
        text_icon=""
        ;;
    "balance_power")
        text_icon=""
        ;;
    "powersave")
        text_icon=""
        ;;
    *)
        #keep defaults if bla bla
        ;;
esac

cpu=/sys/devices/system/cpu

# Energy performance preference (if the driver exposes it)
epp=$(cat "$cpu/cpu0/cpufreq/energy_performance_preference" 2>/dev/null)

# Average current frequency across all cores, in GHz
avg_ghz=$(awk '{s+=$1; n++} END {if (n) printf "%.2f", s/n/1e6}' \
    "$cpu"/cpu[0-9]*/cpufreq/scaling_cur_freq 2>/dev/null)

# Turbo / boost state (Intel pstate or generic cpufreq boost)
turbo=""
if [ -r "$cpu/intel_pstate/no_turbo" ]; then
    [ "$(cat "$cpu/intel_pstate/no_turbo")" = "0" ] && turbo="on" || turbo="off"
elif [ -r "$cpu/cpufreq/boost" ]; then
    [ "$(cat "$cpu/cpufreq/boost")" = "1" ] && turbo="on" || turbo="off"
fi

# Build the tooltip (\n becomes a newline when Waybar parses the JSON)
tooltip_text="Governor: ${governor:-unknown}"
[ -n "$epp" ]     && tooltip_text="${tooltip_text}\nEPP: ${epp}"
[ -n "$avg_ghz" ] && tooltip_text="${tooltip_text}\nAvg freq: ${avg_ghz} GHz"
[ -n "$turbo" ]   && tooltip_text="${tooltip_text}\nTurbo: ${turbo}"

# printf, not echo: some shells (dash) would turn \n into a raw newline and break the JSON
printf '{"text":"%s","tooltip":"%s"}\n' "${text_icon}" "${tooltip_text}"