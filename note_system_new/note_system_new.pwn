#if defined NoteSystemVaribles
	#endinput
#endif
#define NoteSystemVaribles

enum E_NOTE_DATA
{
	N_ID, // ���������� ID �������

	N_AUTHOR[MAX_PLAYER_NAME], // ��� ������, ������� ������ �������
	N_NAME[MAX_NOTE_NAME], // �������� �������, ������� ������ �����
	N_TEXT[NOTE_TEXT_LEN], // ����� �������

	Float:N_POSITION_X,
	Float:N_POSITION_Y,
	Float:N_POSITION_Z,

	Text3D:N_LABEL
};
new g_note_data[MAX_NOTES][E_NOTE_DATA];
new Iterator:g_notes_created<MAX_NOTES>;

enum E_NOTE_PLAYER_DATA
{
	N_ID
};
new g_player_note_data[MAX_PLAYERS][E_NOTE_PLAYER_DATA];