exports('ShowAdvancedNotification', (title, subTitle, dict, icon, duration) => {
	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setInt32(0, duration, true);

	// Notification sounds (Entirely optional, currently disabled)
	//struct1.setBigInt64(8, BigInt(sound_dict), true);
	//struct1.setBigInt64(16, BigInt(sound), true);

	const string1 = CreateVarString(10, "LITERAL_STRING", title);
	const string2 = CreateVarString(10, "LITERAL_STRING", subTitle);

	const struct2 = new DataView(new ArrayBuffer(56));
	struct2.setBigInt64(8, BigInt(string1), true);
	struct2.setBigInt64(16, BigInt(string2), true);
	struct2.setBigInt64(32, BigInt(GetHashKey(dict)), true);
	struct2.setBigInt64(40, BigInt(GetHashKey(icon)), true);
	struct2.setBigInt64(48, BigInt(GetHashKey("COLOR_WHITE")), true);

	Citizen.InvokeNative("0x26E87218390E6729", struct1, struct2, 1, 1);
});

exports('ShowLocationNotification', (text, location, duration) => {
	const string = CreateVarString(10, "LITERAL_STRING", location)
	const string2 = CreateVarString(10, "LITERAL_STRING", text);

	const struct1 = new DataView(new ArrayBuffer(48));
	struct11.setInt32(0, duration, true);
	// Notification sounds (Entirely optional, currently disabled)
	//struct1.setBigInt64(8, BigInt(sound_dict), true);
	//struct1.setBigInt64(16, BigInt(sound), true);

	const struct2 = new DataView(new ArrayBuffer(24));
	struct2.setBigInt64(8, BigInt(string), true);
	struct2.setBigInt64(16, BigInt(string2), true);
	Citizen.InvokeNative("0xD05590C1AB38F068", struct1, struct2, 1);
})

exports('ShowSimpleRightText', (text, duration) => {
	const string = CreateVarString(10, "LITERAL_STRING", text);
	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setInt32(0, duration, true); // Duration

	// Notification sounds (Entirely optional, currently disabled)
	// struct1.setBigInt64(8, BigInt(sound_dict), true);
	// struct1.setBigInt64(16, BigInt(sound), true)

	const struct2 = new DataView(new ArrayBuffer(16));
	struct2.setBigInt64(8, BigInt(string), true);
	Citizen.InvokeNative("0xB48FCED898292E52", struct1, struct2, 1);
});

exports('ShowTopNotification', (title, subtext, duration) => {
	
	const struct1 = new DataView(new ArrayBuffer(48));
	struct1.setInt32(0, duration, true); // Duration

	// Notification sounds (Entirely optional, currently disabled)
	// struct1.setBigInt64(8, BigInt(sound_dict), true);
	// struct1.setBigInt64(16, BigInt(sound), true);

	const string = CreateVarString(10, "LITERAL_STRING", title);
	const string2 = CreateVarString(10, "LITERAL_STRING", subtext);

	const struct2 = new DataView(new ArrayBuffer(48));
	struct2.setBigInt64(8, BigInt(string), true);
	struct2.setBigInt64(16, BigInt(string2), true);

	UiFeedPostTwoTextShard(struct1, struct2, 1, 1);

});

exports('ShowAdvancedRightNotification', (text, dict, icon, text_color, duration) => {

});