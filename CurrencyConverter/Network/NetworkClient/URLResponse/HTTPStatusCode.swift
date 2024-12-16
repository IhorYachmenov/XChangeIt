//
//  HTTPStatusCode.swift
//  CurrencyConverter
//
//  Created by Ice on 16.12.2024.
//

import Foundation

typealias HTTPStatusCode = Int

extension HTTPStatusCode {
    /// Status indicating whether it is an informational response.
    /// - seealso: For more information, see [mdm web docs - Information responses](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#information_responses)
    var isInformational: Bool {
        (100 ..< 200).contains(self)
    }

    /// Status indicating whether it is a successful response.
    /// - seealso: For more information, see [mdm web docs - Successful responses](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#successful_responses)
    var isSuccess: Bool {
        (200 ..< 300).contains(self)
    }

    /// Status indicating whether it is a redirection response.
    /// - seealso: For more information, see [mdm web docs - Redirection messages](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#redirection_messages)
    var isRedirectional: Bool {
        (300 ..< 400).contains(self)
    }

    /// Status indicating whether it is a client error response.
    /// - seealso: For more information, see [mdm web docs - Client error responses](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses)
    var isClientError: Bool {
        (400 ..< 500).contains(self)
    }

    /// Status indicating whether it is a server error response.
    /// - seealso: For more information, see [mdm web docs - Server error responses](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#server_error_responses)
    var isServerError: Bool {
        (500 ..< 600).contains(self)
    }

    /// Status indicating whether it is an error response.
    var isError: Bool {
        (400 ..< 600).contains(self)
    }
}
