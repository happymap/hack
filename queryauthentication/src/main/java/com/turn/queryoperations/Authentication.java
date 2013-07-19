package com.turn.queryoperations;

import java.awt.Desktop;
import java.awt.Desktop.Action;
import java.io.IOException;
import java.net.URI;
import java.util.Arrays;

import com.turn.apis.query.v0.QueryScopes;
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

public class Authentication {
	private static final HttpTransport HTTP_TRANSPORT = new ApacheHttpTransport();
	static final com.google.api.client.json.JsonFactory JSON_FACTORY = new JacksonFactory();
	private static final String TOKEN_SERVER_URL = "https://test.turnapis.com/oauth/token";
	private static final String AUTHORIZATION_SERVER_URL = "https://console.turn.com/oauth/consent";
	private static final String SCOPE = QueryScopes.MPAIGN;
	private String token = null;
	public Authentication() {
		VerificationCodeReceiver receiver = new AuthorizationCodeReceiver();
		try {
			String redirectUri = receiver.getRedirectUri();
			System.out.println(redirectUri);
			launchInBrowser("google-chrome", redirectUri,
					OAuth2ClientCredentials.CLIENT_ID, SCOPE);
			OAuth2ClientCredentials.credential = authorize(receiver, redirectUri);
			token = OAuth2ClientCredentials.credential.getAccessToken();

			System.out.println("access token:" + token);
			System.exit(0);
		} catch (Exception e){
			System.err.println("Authentication fails!");
			System.exit(-1);
		} finally {
			return;
		}
	}

	public static void main(String[] argv) {
		new Authentication();
	}

	private static void launchInBrowser(String browser, String redirectUrl,
			String clientId, String scope) throws IOException {
		String authorizationUrl = new AuthorizationCodeRequestUrl(
				AUTHORIZATION_SERVER_URL, clientId).setRedirectUri(redirectUrl)
				.setScopes(Arrays.asList(scope)).build();
		System.out.println("authorizationUrl uri: " + authorizationUrl);
		if (Desktop.isDesktopSupported()) {
			Desktop desktop = Desktop.getDesktop();
			if (desktop.isSupported(Action.BROWSE)) {
				desktop.browse(URI.create(authorizationUrl));
				return;
			}
		}
		if (browser != null) {
			Runtime.getRuntime().exec(
					new String[] { browser, authorizationUrl });
		} else {
			System.out
					.println("Open the following address in your favorite browser:");
			System.out.println("  " + authorizationUrl);
		}
	}

	private static Credential authorize(VerificationCodeReceiver receiver,
			String redirectUri) throws IOException {
		String code = receiver.waitForCode();
		AuthorizationCodeFlow codeFlow = new AuthorizationCodeFlow.Builder(
				BearerToken.authorizationHeaderAccessMethod(), HTTP_TRANSPORT,
				JSON_FACTORY, new GenericUrl(TOKEN_SERVER_URL),
				new ClientParametersAuthentication(
						OAuth2ClientCredentials.CLIENT_ID,
						OAuth2ClientCredentials.CLIENT_SECRET),
				OAuth2ClientCredentials.CLIENT_ID, AUTHORIZATION_SERVER_URL)
				.setScopes(Arrays.asList(SCOPE)).build();

		TokenResponse response = codeFlow.newTokenRequest(code)
				.setRedirectUri(redirectUri).setScopes(Arrays.asList(SCOPE))
				.execute();

		return codeFlow.createAndStoreCredential(response, null);
	}
}