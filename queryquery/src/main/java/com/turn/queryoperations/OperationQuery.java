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

public class OperationQuery {

	private static Query queryApi = null;

	public Query getApi() {
		return queryApi;
	}
	public OperationQuery(String token) {
		queryApi = new Query(
				new ApacheHttpTransport(),
				new JacksonFactory(),
				new Credential.Builder(BearerToken.authorizationHeaderAccessMethod())
					.build().setAccessToken(token));
	}

	public static void main(String[] argv) {
		OperationQuery instance = new OperationQuery(argv[0]);
		try{
			System.out.println("fake_10101010101");
			instance.getApi().query().query(argv[1], 1L, "Test").execute();
		} catch (IOException e){
			//System.err.println(e.getMessage());
			System.exit(-1);
		}
	}
}