
#define SLEEP_DURATION 60000 // 60 seconds 

new
    IsSleeping[MAX_PLAYERS],
    SleepTimer[MAX_PLAYERS],
    SleepStart[MAX_PLAYERS];

CMD:sleep(playerid, params[])
{
    if (IsSleeping[playerid] == 1)
    {
        SendClientMessage(playerid, COLOR_RED, "You are already sleeping.");
        return 1;
    }

    IsSleeping[playerid] = 1;
    SleepStart[playerid] = GetTickCount();
    SleepTimer[playerid] = SetTimerEx("WakeUpPlayer", SLEEP_DURATION, false, "i", playerid);

    // Black screen
    SetPlayerCameraLookAt(playerid, 0, 0, 0, CAMERA_CUT);
    SendClientMessage(playerid, COLOR_GREEN, "You are now sleeping.");

    return 1;
}

CMD:wakeup(playerid, params[])
{
    if (IsSleeping[playerid] == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "You are not sleeping.");
        return 1;
    }

    KillTimer(SleepTimer[playerid]);
    WakeUpPlayer(playerid);

    return 1;
}

public WakeUpPlayer(playerid)
{
    IsSleeping[playerid] = 0;

    SetPlayerCameraBehindPlayer(playerid);

    if (GetTickCount() - SleepStart[playerid] < SLEEP_DURATION)
    {
        SetPlayerHealth(playerid, GetPlayerHealth(playerid) - 25); // Reduce health
        ResetPlayerWeapons(playerid); // Remove weapons as an example penalty

        SendClientMessage(playerid, COLOR_YELLOW, "You woke up too early and feel weakened.");
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREEN, "You woke up feeling refreshed.");
    }
}
