// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:io';
import 'dart:async';
import 'package:postgres/postgres.dart';
import 'package:dotenv/dotenv.dart' as dotenv;

abstract class DB {

	static get _env => dotenv.env;

	static get _port => 5432;

	static get _host => _env['DB_HOST'];

	static get _user => _env['DB_USER'];

	static get _pass => _env['DB_PASS'];

	static get _name => _env['DB_NAME'];

	static PostgreSQLConnection _connection;

	static Future<void> init() async {

		DB._connection = new PostgreSQLConnection(_host, _port, _name, username: _user, password: _pass);
		return await _connection.open();
	}

	static Future<List<dynamic>> query(String sql, { Map<String, dynamic> values }) async {

		try { 
			return await _connection.mappedResultsQuery(sql, substitutionValues: values); 
		}
		catch(e) { 
			return Future.value([]); 
		}
	}
}