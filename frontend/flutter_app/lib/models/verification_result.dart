class VerificationCheckItem {
  final String title;
  final String detail;
  final bool isMatched;

  VerificationCheckItem({
    required this.title,
    required this.detail,
    required this.isMatched,
  });
}

class VerificationResult {
  final String scoreRatio; // e.g. "4/5 Checks Matched"
  final String statusText; // e.g. "Attention Required"
  final bool isAttentionRequired;
  final String advisoryText;
  final List<VerificationCheckItem> checklist;

  VerificationResult({
    required this.scoreRatio,
    required this.statusText,
    required this.isAttentionRequired,
    required this.advisoryText,
    required this.checklist,
  });

  static VerificationResult sampleResult() {
    return VerificationResult(
      scoreRatio: '4/5 Checks Matched',
      statusText: 'Attention Required',
      isAttentionRequired: true,
      advisoryText:
          'The available product information is mostly consistent, but the batch could not be matched against the current reference dataset. This does not by itself prove the product is counterfeit. Professional review recommended.',
      checklist: [
        VerificationCheckItem(
          title: 'Medicine Name',
          detail: 'Matches reference catalog (Glycomet)',
          isMatched: true,
        ),
        VerificationCheckItem(
          title: 'Strength',
          detail: 'Matches registered formulation (500 mg)',
          isMatched: true,
        ),
        VerificationCheckItem(
          title: 'Manufacturer',
          detail: 'Matches licensee (USV Private Limited)',
          isMatched: true,
        ),
        VerificationCheckItem(
          title: 'Expiry Date',
          detail: 'Valid shelf-life format (07/2027)',
          isMatched: true,
        ),
        VerificationCheckItem(
          title: 'Batch Number',
          detail: 'Batch PCM82491 not found in current reference dataset',
          isMatched: false,
        ),
      ],
    );
  }
}
