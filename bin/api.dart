// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:io';
import 'dart:async';
import 'package:postgres/postgres.dart';
import './db.dart';

abstract class API { 

	static Future<List<dynamic>> getLibraryIndex() async {

		var result = await DB.query('select * from library_items where is_active = true');
	
		return result;
	}
	
	static init() async {
		
		return await DB.init();
	}
}