#if !defined NoteSystem
	#define NoteSystem:%0(%1)	                NoteSystem%0(%1)
#endif

#if !defined NOTE_TEXT_LEN
	#define NOTE_TEXT_LEN						512
#endif

#if !defined MAX_NOTES
	#define MAX_NOTES							100
#endif

#if !defined MAX_NOTE_NAME
	#define MAX_NOTE_NAME						16
#endif

#if !defined INVALID_NOTE_ID
	#define INVALID_NOTE_ID						-1
#endif

#if !defined DIALOG_NOTE
	#define DIALOG_NOTE							0
#endif

#if !defined DIALOG_NOTE_CREATE_NAME
	#define DIALOG_NOTE_CREATE_NAME				1
#endif

#if !defined DIALOG_NOTE_CREATE_TEXT
	#define DIALOG_NOTE_CREATE_TEXT				2
#endif

#if !defined DIALOG_NOTE_SET_AUTHOR
	#define DIALOG_NOTE_SET_AUTHOR				3
#endif

#if !defined DIALOG_NOTE_READ
	#define DIALOG_NOTE_READ					4
#endif

#if !defined NOTE_DISTANCE
	#define NOTE_DISTANCE						5.0
#endif

#if !defined DIALOG_NOTE_NULL
	#define DIALOG_NOTE_NULL					5
#endif

#tryinclude <note_system/note_system_new/note_system_new.pwn>
#tryinclude <note_system/note_system_public/note_system_public.pwn>

stock NoteSystem:init()
{
	#if defined NoteSystemInitialized
		#endinput
	#endif

	#if defined NoteSystemVaribles && defined NoteSystemPublics
		#define NoteSystemInitialized
	#else
		return printf("[Note System] Необходимые компоненты не обнаружены. Загрузка невозможна!");
	#endif

	for(new i; i < MAX_NOTES; i++)
	{
		g_note_data[i][N_AUTHOR][0] = EOS;

	    g_note_data[i][N_TEXT][0] = EOS;
	    g_note_data[i][N_NAME][0] = EOS;

	    g_note_data[i][N_POSITION_X] = -1.0;
	    g_note_data[i][N_POSITION_Y] = -1.0;
	    g_note_data[i][N_POSITION_Z] = -1.0;
	}

	return printf("[Note System] Необходимые компоненты были обнаружены. Загрузка завершена!");
}

stock NoteSystem:SetNoteAuthor(const note_id, const author[] = "Неизвестно", const author_len )
{
	if(!NoteSystemIsValidNote(note_id))
		return INVALID_NOTE_ID;

	return format(g_note_data[note_id][N_AUTHOR], author_len, "%s", author);
}

stock NoteSystem:SetNoteName(const note_id, const name[] = "Записка", const note_len)
{
	if(!NoteSystemIsValidNote(note_id))
		return INVALID_NOTE_ID;

	return format(g_note_data[note_id][N_NAME], note_len, "%s", name);
}

stock NoteSystem:SetNoteText(const note_id, const note_text[], const note_len )
{
	if(!NoteSystemIsValidNote(note_id))
		return INVALID_NOTE_ID;

	return format(g_note_data[note_id][N_TEXT], note_len, "%s", note_text);
}

stock NoteSystem:CreateNote(playerid, const note_name[] = "Записка")
{
	if(Iter_Count(g_notes_created) > MAX_NOTES)
		return INVALID_NOTE_ID;
	if(!IsPlayerConnected(playerid))
		return INVALID_PLAYER_ID;

	Iter_Add(g_notes_created, Iter_Count(g_notes_created)++); // Добавление нового значению для итератора

	new note_id = Iter_Count(g_notes_created);
	g_player_note_data[playerid][N_ID] = note_id;

	return ShowPlayerDialog(playerid, DIALOG_NOTE_CREATE_TEXT, DIALOG_STYLE_INPUT, "Создание записки", "Укажите пожалуйста содержание записки", "Далее", "Отмена");
}

stock NoteSystem:ShowNote(playerid, const note_id)
{
	if(!NoteSystemIsValidNote(note_id))
		return INVALID_NOTE_ID;
	if(!IsPlayerConnected(playerid))
		return INVALID_PLAYER_ID;

	return ShowPlayerDialog(playerid, DIALOG_NOTE, DIALOG_STYLE_LIST, "Взаимодействие с запиской", "1. Написать записку\n2. Прочитать записку\n3. Бросить на землю\n4. Поднять с земли", "Выбрать", "Отмена");
}