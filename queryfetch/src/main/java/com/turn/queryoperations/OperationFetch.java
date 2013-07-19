package com.turn.queryoperations;

import com.turn.apis.query.v0.Query;

import java.io.IOException;

import com.google.api.client.auth.oauth2.AuthorizationCodeFlow;
import com.google.api.client.auth.oauth2.AuthorizationCodeRequestUrl;
import com.google.api.client.auth.oauth2.BearerToken;
import com.google.api.client.auth.oauth2.ClientParametersAuthentication;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.apache.ApacheHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

public class OperationFetch {

	private static Query queryApi = null;

	public Query getApi() {
		return queryApi;
	}

	public OperationFetch(String token) {
		queryApi = new Query(
				new ApacheHttpTransport(),
				new JacksonFactory(),
				new Credential.Builder(BearerToken.authorizationHeaderAccessMethod())
					.build().setAccessToken(token));
		System.out.println(token);
	}

	public static void main(String[] argv) {
		OperationFetch instance = new OperationFetch(argv[0]);
		System.out.println(argv[1]);
		long start = Long.parseLong(argv[1]);
		long limit = Long.parseLong(argv[2]);
		long queryId = Long.parseLong(argv[3]);
		try{
			instance.getApi().query().fetch(start, limit, queryId).execute();
		} catch (IOException e){
			System.err.println("Authentication fails!");
			System.exit(-1);
		}
	}
}