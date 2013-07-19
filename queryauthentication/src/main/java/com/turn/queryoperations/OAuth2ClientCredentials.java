package com.turn.queryoperations;

import com.google.api.client.auth.oauth2.Credential;

/*
 * Copyright (c) 2011 Google Inc.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */



/**
 * OAuth 2 credentials found in the <a href="http://www.dailymotion.com/profile/developer">
 * Developer Profile Page</a>.
 * 
 * <p>
 * Once at the Developer Profile page, you will need to create a Daily Motion account if you do not
 * already have one. Click on "Create a new API Key". Enter "http://127.0.0.1:8080/Callback" under
 * "Callback URL" and select "Native Application" under "Application Profile". Enter a port number
 * other than 8080 if that is what you intend to use.
 * </p>
 * 
 * @author Ravi Mistry
 */
public class OAuth2ClientCredentials {

	
  /** Value of the "API Key". */
  public static final String CLIENT_ID = "5tm2w9j6s9v75ch5ryx2y725";
  // public static final String CLIENT_ID = "yqza5tu9quvpjwgk6gvecsbw";

  /** Value of the "API Secret". */
  public static final String CLIENT_SECRET = "";

  public static Credential credential = null;
  
  
  /*  *//** Value of the "API Key". */
  /*
   * public static final String CLIENT_ID = "3b8aa5778cb0ba43322a";
   *//** Value of the "API Secret". */
  /*
   * public static final String CLIENT_SECRET = "899f089d9e1b420b298d40ceed956ce733982d92";
   */

  public static void errorIfNotSpecified() {
    if (CLIENT_ID.startsWith("Enter ")) {
      System.err.println(CLIENT_ID);
      System.exit(1);
    }
    if (CLIENT_SECRET.startsWith("Enter ")) {
      System.err.println(CLIENT_SECRET);
      System.exit(1);
    }
  }
}
