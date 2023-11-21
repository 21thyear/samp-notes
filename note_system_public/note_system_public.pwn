#if defined NoteSystemPublics
    #endinput
#endif
#define NoteSystemPublics

public: bool:NoteSystemIsValidNote(const note_id)
{
    foreach(new i : g_notes_created)
    {
        if(i != note_id)
        {
            continue;
        }

        else
        {
            return true;
        }
    }
    return false;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_NOTE:
        {
            if(!response)
            {
                return false;
            }

            switch(listitem)
            {
                case 0:
                {
                    ShowPlayerDialog(playerid, DIALOG_NOTE_CREATE_NAME, DIALOG_STYLE_INPUT, "Создание записки", "Укажите название записки", "Далее", "Отмена");
                }
                case 1:
                {

                    new string[40]; 
                    format(string, sizeof(string), "Автор записки: %s", g_note_data[g_player_note_data[playerid][N_ID]][N_NAME]);

                    SendClientMessageEx(playerid, -1, string);
                    ShowPlayerDialog(playerid, DIALOG_NOTE_READ, DIALOG_STYLE_MSGBOX, g_note_data[g_player_note_data[playerid][N_ID]][N_NAME], g_note_data[g_player_note_data[playerid][N_ID]][N_TEXT], "Закрыть", "");
                }
                case 2:
                {
                    if(g_player_note_data[playerid][N_ID] > -1)
                    {
                        new note_id = g_player_note_data[playerid][N_ID];
                        
                        GetPlayerPos(
                            playerid,
                            g_note_data[note_id][N_POSITION_X],
                            g_note_data[note_id][N_POSITION_Y],
                            g_note_data[note_id][N_POSITION_Z]
                        );

                        g_note_data[g_player_note_data[playerid][N_ID]][N_LABEL] = Create3DTextLabel("Записка. Чтобы поднять нажмите \"K. ALT\"", -1, g_note_data[g_player_note_data[playerid][N_ID]][N_POSITION_X], g_note_data[g_player_note_data[playerid][N_ID]][N_POSITION_Y], g_note_data[g_player_note_data[playerid][N_ID]][N_POSITION_Z], 5.0, -1, -1);
                    }
                }
                case 3:
                {
                    new note_id;

                    foreach(new i : Player)
                    {
                        if(g_player_note_data[i][N_ID] == -1) continue;

                        note_id = g_player_note_data[i][N_ID];

                        foreach(new player : g_notes_created)
                        {
                            if(!IsPlayerInRangeOfPoint(playerid, NOTE_DISTANCE, g_note_data[note_id][N_POSITION_X],  g_note_data[note_id][N_POSITION_Y],  g_note_data[note_id][N_POSITION_Z]))
                            {
                                continue;
                            }

                            Delete3DTextLabel(g_note_data[note_id][N_LABEL]);
                            ShowPlayerDialog(playerid, DIALOG_NOTE_NULL, DIALOG_STYLE_MSGBOX, g_note_data[note_id][N_NAME], g_note_data[note_id][N_TEXT], "Закрыть", "");
                            
                            break;
                        }

                        break;
                    }
                }
            }
        }

        case DIALOG_NOTE_CREATE_NAME:
        {
            if(!response)
            {
                return false;
            }

            return NoteSystem:CreateNote(playerid, inputtext); // Создаем записку
        }

        case DIALOG_NOTE_CREATE_TEXT:
        {
            if(!response)
            {
                return false;
            }

            ShowPlayerDialog(playerid, DIALOG_NOTE_SET_AUTHOR, DIALOG_STYLE_INPUT, "Создание записки", "Укажите имя автора. Вы можете его не использовать, и имя будет \"Неизвестно\"", "Далее", "Отмена");
            return NoteSystem:SetNoteText(g_player_note_data[playerid][N_ID], inputtext, strlen(inputtext));
        }

        case DIALOG_NOTE_SET_AUTHOR:
        {
            if(!response)
            {
                return NoteSystem:SetNoteAuthor(g_player_note_data[playerid][N_ID], _, strlen(inputtext));
            }

            SendClientMessage(playerid, -1, "Записка создана");
            return NoteSystem:SetNoteAuthor(g_player_note_data[playerid][N_ID], inputtext, strlen(inputtext));
        }
    }


    #if defined Note_OnDialogResponse
        return Note_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
    #else
        return true;
    #endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif

#define OnDialogResponse Note_OnDialogResponse
#if defined Note_OnDialogResponse
    forward Note_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif

public OnPlayerConnect(playerid)
{
    g_player_note_data[playerid][N_ID] = -1;
    #if defined Note_OnPlayerConnect
        return Note_OnPlayerConnect(playerid);
    #else
        return true;
    #endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect Note_OnPlayerConnect
#if defined Note_OnPlayerConnect
    forward Note_OnPlayerConnect(playerid);
#endif

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_WALK)
    {
        if(g_player_note_data[playerid][N_ID] == -1)
        {
            return ShowPlayerDialog(playerid, DIALOG_NOTE_CREATE_NAME, DIALOG_STYLE_INPUT, "Создание записки", "Укажите название записки", "Далее", "Отмена");
        }
        else
        {

        }
    }
    #if defined Note_OnPlayerKeyStateChange
        return Note_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
    #else
        return true;
    #endif
}
#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange Note_OnPlayerKeyStateChange
#if defined Note_OnPlayerKeyStateChange
    forward Note_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif