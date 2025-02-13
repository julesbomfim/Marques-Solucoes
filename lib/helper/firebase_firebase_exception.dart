String getFirebaseException(String code) {
  switch (code) {
    case 'object-not-found':
      return 'Nenhum objeto na referência desejada.';
    case 'unknown':
      return 'Ocorreu um erro desconhecido.';
    case 'bucket-not-found':
      return 'Nenhum bucket configurado para o Cloud Storage.';
    case 'project-not-found':
      return 'Nenhum projeto configurado para o Cloud Storage.';
    case 'quota-exceeded':
      return 'A cota do bucket do Cloud Storage foi excedida.';
    case 'unauthenticated':
      return 'O usuário não está autenticado.';
    case 'unauthorized':
      return 'O usuário não está autorizado a executar a ação desejada.';
    case 'retry-limit-exceeded':
      return 'O limite de tempo em uma operação (upload, download, exclusão etc.) foi excedido.';

    case 'invalid-checksum':
      return 'O arquivo no cliente não corresponde à soma de verificação do arquivo recebido pelo servidor.';

    case 'canceled':
      return 'O usuário cancelou a operação';

    case 'no-default-bucket':
      return 'Nenhum bucket foi definido na propriedade storageBucket da configuração.';

    default:
      return 'Erro Desconhecido';
  }
}
