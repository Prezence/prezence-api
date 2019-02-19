// Prezence - Copyright 2019 The Innovation Group
// @author Kenneth Reilly <kenneth@innovationgroup.tech>

import 'dart:io';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:dotenv/dotenv.dart' as dotenv;
import './api.dart';

abstract class APIServer {

	static dynamic _handler;

	static void init() async {

		dotenv.load();

		API.init();

		_handler = const Pipeline()
			.addMiddleware(logRequests())
	        .addHandler(echo);

		// var securityContext = SecurityContext()
		int _port = int.parse(dotenv.env['PORT']);
    	HttpServer server = await io.serve(_handler, '127.0.0.1', _port);
    	print('Serving at http://${server.address.host}:${server.port}');
	}

	static Future<Response> echo(Request request) async {
		
		// return Response.ok('Request for "${request.url}"');

		try {
			String url = request.url.toString();
			switch (url) {

				case 'library-index':
					var data = await API.getLibraryIndex();
					String json = jsonEncode(data, toEncodable: (Object object) {
						return object.toString();
					});
					return Response.ok(json);

				case '':
				default:
					return Response.ok('API version 1.0');
			}
		}
		catch(ex) {
			print(ex);
		}
	
	}
}

Future<void> main(List<String> args) async => APIServer.init();